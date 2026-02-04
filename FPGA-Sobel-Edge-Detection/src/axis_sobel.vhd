library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity axis_sobel is
    generic (
        IMG_WIDTH  : integer := 1920; 
        DATA_WIDTH : integer := 8
    );
    port (
        clk           : in  std_logic;
        aresetn       : in  std_logic;
        s_axis_tdata  : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        s_axis_tvalid : in  std_logic;
        s_axis_tready : out std_logic;
        m_axis_tdata  : out std_logic_vector(DATA_WIDTH-1 downto 0);
        m_axis_tvalid : out std_logic;
        m_axis_tready : in  std_logic
    );
end axis_sobel;

architecture Behavioral of axis_sobel is
    type line_array is array (0 to IMG_WIDTH-1) of unsigned(DATA_WIDTH-1 downto 0);
    signal line_buffer_1 : line_array := (others => (others => '0'));
    signal line_buffer_2 : line_array := (others => (others => '0'));
    
    signal p11, p12, p13 : integer := 0;
    signal p21, p22, p23 : integer := 0;
    signal p31, p32, p33 : integer := 0;
    
    signal col_cnt : integer range 0 to IMG_WIDTH-1 := 0;
    
    signal Gx, Gy : integer := 0;
    signal Gsum   : integer := 0;

begin
    s_axis_tready <= m_axis_tready;

    process(clk)
    begin
        if rising_edge(clk) then
            if aresetn = '0' then
                col_cnt <= 0;
                m_axis_tvalid <= '0';
            elsif s_axis_tvalid = '1' and m_axis_tready = '1' then
                p11 <= p12; p12 <= p13;
                p13 <= to_integer(line_buffer_2(col_cnt));
                
                p21 <= p22; p22 <= p23;
                p23 <= to_integer(line_buffer_1(col_cnt));
                
                p31 <= p32; p33 <= to_integer(unsigned(s_axis_tdata));
                p32 <= p33;

                line_buffer_2(col_cnt) <= line_buffer_1(col_cnt);
                line_buffer_1(col_cnt) <= unsigned(s_axis_tdata);

                Gx <= (p13 + (p23 * 2) + p33) - (p11 + (p21 * 2) + p31);
                Gy <= (p11 + (p12 * 2) + p13) - (p31 + (p32 * 2) + p33);

                Gsum <= abs(Gx) + abs(Gy);

                if (abs(Gx) + abs(Gy)) > 100 then
                    m_axis_tdata <= (others => '1');
                else
                    m_axis_tdata <= (others => '0');
                end if;

                m_axis_tvalid <= '1';

                if col_cnt = IMG_WIDTH - 1 then
                    col_cnt <= 0;
                else
                    col_cnt <= col_cnt + 1;
                end if;
            else
                m_axis_tvalid <= '0';
            end if;
        end if;
    end process;

end Behavioral;
