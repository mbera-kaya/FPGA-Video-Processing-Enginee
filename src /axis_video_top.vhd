--------------------------------------------------------------------------------
-- Project: Real-Time FPGA Video Processing
-- Module: Top Level Design
-- Author: Mehmet Bera Kaya
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity axis_video_top is
    Port (
        clk           : in  std_logic;
        reset_n       : in  std_logic;
        -- Video Input Stream (RGB)
        s_axis_tdata  : in  std_logic_vector(23 downto 0);
        s_axis_tvalid : in  std_logic;
        s_axis_tready : out std_logic;
        -- Video Output Stream (Grayscale)
        m_axis_tdata  : out std_logic_vector(7 downto 0);
        m_axis_tvalid : out std_logic;
        m_axis_tready : in  std_logic
    );
end axis_video_top;

architecture Structural of axis_video_top is

    -- Grayscale Component Declaration
    component axis_grayscale
        Port (
            clk           : in  std_logic;
            reset_n       : in  std_logic;
            s_axis_tdata  : in  std_logic_vector(23 downto 0);
            s_axis_tvalid : in  std_logic;
            s_axis_tready : out std_logic;
            m_axis_tdata  : out std_logic_vector(7 downto 0);
            m_axis_tvalid : out std_logic;
            m_axis_tready : in  std_logic
        );
    end component;

begin

    -- Instantiating Grayscale Processing Core
    U_GRAYSCALE_CORE: axis_grayscale
        port map (
            clk           => clk,
            reset_n       => reset_n,
            s_axis_tdata  => s_axis_tdata,
            s_axis_tvalid => s_axis_tvalid,
            s_axis_tready => s_axis_tready,
            m_axis_tdata  => m_axis_tdata,
            m_axis_tvalid => m_axis_tvalid,
            m_axis_tready => m_axis_tready
        );

end Structural;
