library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity axis_grayscale is
    Port (
        clk           : in  std_logic;
        reset_n       : in  std_logic;
        -- Slave Interface (RGB Input)
        s_axis_tdata  : in  std_logic_vector(23 downto 0);
        s_axis_tvalid : in  std_logic;
        s_axis_tready : out std_logic;
        -- Master Interface (Gray Output)
        m_axis_tdata  : out std_logic_vector(7 downto 0);
        m_axis_tvalid : out std_logic;
        m_axis_tready : in  std_logic
    );
end axis_grayscale;

architecture Behavioral of axis_grayscale is
begin
    process(clk)
        variable r, g, b : unsigned(7 downto 0);
        variable gray    : unsigned(7 downto 0);
    begin
        if rising_edge(clk) then
            if reset_n = '0' then
                m_axis_tvalid <= '0';
            else
                s_axis_tready <= m_axis_tready;
                if s_axis_tvalid = '1' and m_axis_tready = '1' then
                    r := unsigned(s_axis_tdata(23 downto 16));
                    g := unsigned(s_axis_tdata(15 downto 8));
                    b := unsigned(s_axis_tdata(7 downto 0));
                    -- (R+G+B)/4 approximation for resource efficiency
                    gray := (r/4) + (g/2) + (b/4); 
                    m_axis_tdata  <= std_logic_vector(gray);
                    m_axis_tvalid <= '1';
                else
                    m_axis_tvalid <= '0';
                end if;
            end if;
        end if;
    end process;
end Behavioral;
