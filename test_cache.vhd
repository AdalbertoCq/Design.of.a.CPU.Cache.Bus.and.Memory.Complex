library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity test_cache is
end entity;

architecture behav of test_cache is
	--Component Declaration of UUT
	component Cache 
		port(
			cacheType : in std_logic; -- Icahe=0;
			Dcache=1
			stateTrans : in std_logic_vector(2 downto 0);
			address_in : in std_logic_vector(31 downto 0);
			data_in : in std_logic_vector(31 downto 0);
			opType : in std_logic_vector(1 downto 0);
			data_out : out std_logic_vector(31 downto 0);
			address_out: out std_logic_vector(31 downto 0);
			IHc : out std_logic;
			DHc : out std_logic;
			dbset : out std_logic;
			trasn_out : out std_logic
		);
	end component;
	
	signal cacheType : std_logic := '0';
	signal stateTrans : std_logic_vector(2 downto 0) := (others >'0');
	signal address_in : std_logic_vector(31 downto 0) := (others =>'0');
	signal data_in : std_logic_vector(31 downto 0) := (others =>'0');
	signal opType : std_logic_vector(1 downto 0) := (others =>'0');
	signal data_out : std_logic_vector(31 downto 0);
	signal address_out : std_logic_vector(31 downto 0);
	signal IHc : std_logic;
	signal DHc : std_logic;
	signal dbset : std_logic;
	signal trasn_out : std_logic;
	
		begin
		--UUT
		uut: Cache 
			port map(
				cacheType => cacheType,
				stateTrans => stateTrans,
				address_in => address_in,
				data_in => data_in,
				opType => opType,
				data_out =>data_out,
				address_out => address_out,
				IHc => IHc,
				DHc => DHc,
				dbset => dbset,
				trasn_out => trasn_out
			);
		
			tb: process
				begin
				
				--Transfer for ICache, Test if the word is correctly written in his corresponding place of the row.
				--Block, word 0.

				wait for 100 ns;
				cacheType <= '0'; opType<="10";stateTrans<="000"; address_in <= "00000000000000000000000000000000"; 
				data_in <= "00000000000000000000000000000000";
				wait for 100 ns;

				--Block, word 1.
				cacheType <= '0'; opType<="10";stateTrans<="001"; address_in<= "00000000000000000000000000000100"; 
				data_in <= "00000000000000000000000000000001";
				wait for 100 ns;

				--Block, word 2.
				cacheType <= '0'; opType<="10";stateTrans<="010"; 
				address_in <= "00000000000000000000000000001000"; 
				data_in <="00000000000000000000000000000010";
				wait for 100 ns;
				
				--Block, word 3.
				cacheType <= '0'; opType<="10";stateTrans<="011";
				 address_in <= "00000000000000000000000000001100"; 
				data_in <= "00000000000000000000000000000011";
				wait for 100 ns;
				
				--Block, word 4.
				cacheType <= '0'; 
				opType<="10";stateTrans<="100"; 
				address_in <= "00000000000000000000000000010000"; 
				data_in <= "00000000000000000000000000000100";
				wait for 100 ns;
				
				--Block, word 5.
				cacheType <= '0'; 
				opType<="10";
				stateTrans<="101"; 
				address_in <= "00000000000000000000000000010100"; 
				data_in <= "00000000000000000000000000000101";
				wait for 100 ns;
				
				--Block, word 6.
				cacheType <= '0'; 
				opType<="10";
				stateTrans<="110";
				address_in <= "00000000000000000000000000011000"; 
				data_in <= "00000000000000000000000000000110";
				wait for 100 ns;
				
				--Block, word 7.
				cacheType <= '0'; 
				opType<="10";
				stateTrans<="111"; 
				address_in <= "00000000000000000000000000011100"; 
				data_in <= "00000000000000000000000000000111";
				wait for 100 ns;
				
				--Transfer for ICache, Test if the word is correctly written in his corresponding row. Row = 1.
				--Block, word 0.
				wait for 100 ns;
				cacheType <= '0'; 
				opType<="10";
				stateTrans<="000"; 
				address_in <= "00000000000000000000000000100000"; 
				data_in <= "00000000000000000000000000000000";
				wait for 100 ns;
				
				--Block, word 1.
				cacheType <= '0'; 
				opType<="10";stateTrans<="001"; 
				address_in <= "00000000000000000000000000100100"; 
				data_in <= "00000000000000000000000000000001";
				wait for 100 ns;
				
				--Block, word 2.
				cacheType <= '0'; 
				opType<="10";
				stateTrans<="010"; 
				address_in 	<= "00000000000000000000000000101000"; 
				data_in <= "00000000000000000000000000000010";
				wait for 100 ns;
				
				--Block, word 3.
				cacheType <= '0';
				opType<="10";
				stateTrans<="011";
				address_in <= "00000000000000000000000000101100"; 
				data_in <= "00000000000000000000000000000011";
				wait for 100 ns;
				
				--Block, word 4.
				cacheType <= '0'; 
				opType<="10";stateTrans<="100"; 
				address_in <= "00000000000000000000000000110000"; 
				data_in <= "00000000000000000000000000000100";
				wait for 100 ns;
				
				--Block, word 5.
				cacheType <= '0'; 
				opType<="10";stateTrans<="101"; 
				address_in <= "00000000000000000000000000110100"; 
				data_in <= "00000000000000000000000000000101";
				wait for 100 ns;
				
				--Block, word 6.
				cacheType <= '0'; 
				opType<="10";
				stateTrans<="110"; 
				address_in <= "00000000000000000000000000111000"; 
				data_in <= "00000000000000000000000000000110";
				wait for 100 ns;
				
				--Block, word 7.
				cacheType <= '0'; 
				opType<="10";stateTrans<="111"; 
				address_in <= "00000000000000000000000000111100"; 
				data_in <= "00000000000000000000000000000111";
				wait for 100 ns;
				
				--Read for ICache, test the Hit case.
				cacheType <= '0'; 
				opType<="00";
				stateTrans<="011"; 
				address_in <= "00000000000000000000000000101100";
				wait for 100 ns;
				
				--Read for ICache, test the miss case.
				cacheType <= '0'; 
				opType<="00";
				stateTrans<="011"; 
				address_in <= "00000000000000000000000011101100";
				wait for 100 ns;
				wait;

			end process;
end architecture;