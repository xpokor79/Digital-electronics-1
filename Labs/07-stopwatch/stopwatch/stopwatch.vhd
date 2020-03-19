
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for stopwatch
------------------------------------------------------------------------
entity stopwatch is
port(
	--inputs
	clk_i			: in std_logic;
	srst_n_i		: in std_logic; -- Synch. reset (active low)
	ce_100Hz_i 	: in std_logic; -- Clock enable 100Hz => T = 0.01s
	cnt_en_i		: in std_logic; -- Stopwatch enable
	
	--outputs
	sec_h_o		: out std_logic_vector(4-1 downto 0);  --Counter for tens of seconds
	sec_l_o		: out std_logic_vector(4-1 downto 0);  --			for seconds
	hth_h_o		: out std_logic_vector(4-1 downto 0);  --			for tenths of seconds
	hth_l_o		: out std_logic_vector(4-1 downto 0)	 --		for hundreths of seconds
);
end entity stopwatch;

------------------------------------------------------------------------
-- Architecture declaration for stopwatch
------------------------------------------------------------------------
architecture Behavioral of stopwatch is
	signal s_cnt0 : unsigned(4-1 downto 0) := (others => '0'); --hth_l (hundreths of seconds)
	signal s_cnt1 : unsigned(4-1 downto 0) := (others => '0'); --hth_h (tenths of seconds)
	signal s_cnt2 : unsigned(4-1 downto 0) := (others => '0'); --sec_l (seconds)
	signal s_cnt3 : unsigned(4-1 downto 0) := (others => '0'); --sec_h (tens of seconds)
	

begin
  -- should be in top 
	-- Sub-block of clock_enable entity
--	CLK_EN_00 : entity work.clock_enable
--	generic map(
--		g_NPERIOD => x"0064" -- f=10 kHz => T=100ns. 10ms = 100*T. 100(dec) = 0064 (hex)
--	)
--	port map (
--		clk_i => clk_i,
--		srst_n_i => srst_n_i,
--		clock_enable_o => s_en
--	);
	
	
	p_cnt : process(clk_i)
	begin
		if rising_edge(clk_i) then
			if srst_n_i = '0'  then  -- synch reset
				s_cnt0 <= (others => '0'); --set to 0
				s_cnt1 <= (others => '0');
				s_cnt2 <= (others => '0');
				s_cnt3 <= (others => '0');
				
			elsif ce_100Hz_i = '1' then
				if cnt_en_i = '1' then
					if (s_cnt3 = 5) and(s_cnt2 = 9) and (s_cnt1 = 9) and (s_cnt0 = 9) then -- 59:99 (1 min) 
						s_cnt0 <= (others => '0'); --set to 0
						s_cnt1 <= (others => '0');
						s_cnt2 <= (others => '0');
						s_cnt3 <= (others => '0');
						
					elsif (s_cnt2 = 9) and (s_cnt1 = 9) and (s_cnt0 = 9) then -- X9:99
						s_cnt3 <= s_cnt3 + 1;
						s_cnt0 <= (others => '0'); --set to 0
						s_cnt1 <= (others => '0');
						s_cnt2 <= (others => '0');
						
					elsif (s_cnt1 = 9) and (s_cnt0 = 9) then -- XX:99
						s_cnt2 <= s_cnt2 + 1;
						s_cnt0 <= (others => '0');
						s_cnt1 <= (others => '0');
						
					elsif (s_cnt0 = 9) then -- XX:X9
						s_cnt1 <= s_cnt1 + 1;
						s_cnt0 <= (others => '0');
					
					else 
						s_cnt0 <= s_cnt0 + 1;
						
					end if;
				end if;
			end if;
		end if;
		
	hth_l_o <= std_logic_vector(s_cnt0);
	hth_h_o <= std_logic_vector(s_cnt1);
	sec_l_o <= std_logic_vector(s_cnt2);
	sec_h_o <= std_logic_vector(s_cnt3);
	
	end process p_cnt;
end architecture Behavioral;

