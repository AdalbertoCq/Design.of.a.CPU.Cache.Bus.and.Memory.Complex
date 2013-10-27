library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity Cache is 
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
end entity;


Architecture behav of Cache is
	type iCacheMem is array(31 downto 0) of std_logic_vector(282
	downto 0);
	type dCacheMem is array(15 downto 0) of std_logic_vector(282
	downto 0);
	type prob is array(31 downto 0) of std_logic_vector(26 downto 0);
	signal pa : prob;
	signal pr : std_logic_vector(282 downto 0);
	signal iblk: iCacheMem := (others =>(others=>'0'));
	signal dblk: dCacheMem := (others =>(others=>'0'));
	signal addr: std_logic_vector(26 downto 0);
	signal comp: std_logic_vector(26 downto 0);
	begin

	--Read Instruction Cache
	process( cacheType, stateTrans, opType, address_in, data_in)
		variable temp: std_logic_vector(26 downto 0);
		--ICache aux variables
		variable iaddress_in: integer;
		--DCache aux variables
		variable daddress_in: integer;
		begin
			--Read
			if opType="00" then
			-- ICache
				if cacheType='0' then
					--Compares the tag into the cache.
					for I in 0 to 31 loop
						if (address_in(31 downto 5) = iblk(31-I)(282 downto 256)) then
							--- Hit case
							case address_in(4 downto 2) is 
								when "111" => data_out <= iblk(31- I)(255 downto 224); IHc <= '1';--word 7
								when "110" => data_out <= iblk(31- I)(223 downto 192); IHc <= '1'; --word 6
								when "101" => data_out <= iblk(31- I)(191 downto 160); IHc <= '1'; --word 5
								when "100" => data_out <= iblk(31- I)(159 downto 128); IHc <= '1'; --word 4
								when "011" => data_out <= iblk(31- I)(127 downto 96); IHc <= '1'; --word 3
								when "010" => data_out <= iblk(31- I)(95 downto 64); IHc <= '1'; --word 2
								when "001" => data_out <= iblk(31- I)(63 downto 32); IHc <= '1'; --word 1
								when "000" => data_out <= iblk(31- I)(31 downto 0); IHc <= '1'; --word 0
								when others => data_out <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
							end case;
							exit;
						else
							--- Miss case
							IHc <='0';
							address_out <= address_in;
						end if;
					end loop;
				end if;
				-- DCache
				if cacheType = '1' then
					--Compares the tag into the cache.
					for I in 0 to 15 loop
						if (address_in(31 downto 5) = dblk(15-I)(282 downto 256)) then
							--- Hit case
							case address_in(4 downto 2) is
								when "111" => data_out <= dblk(15- I)(255 downto 224); DHc <= '1'; --word 7
								when "110" => data_out <= dblk(15- I)(223 downto 192); DHc <= '1';--word 6
								when "101" => data_out <= dblk(15- I)(191 downto 160); DHc <= '1';--word 5
								when "100" => data_out <= dblk(15- I)(159 downto 128); DHc <= '1';--word 4
								when "011" => data_out <= dblk(15- I)(127 downto 96); DHc <= '1';--word 3
								when "010" => data_out <= dblk(15- I)(95 downto 64); DHc <= '1';--word 2
								when "001" => data_out <= dblk(15- I)(63 downto 32); DHc <= '1';--word 1
								when "000" => data_out <= dblk(15- I)(31 downto 0); DHc <= '1';--word 0
								when others => data_out <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
							end case;
							exit;
						else
							--- Miss case
							DHc <='0';
							address_out <= address_in;
						end if;
					end loop;
				end if;
			end if;

			--Write
			if opType="01" then
				-- DCache
				if cacheType='1' then
					for I in 0 to 15 loop
						if address_in(31 downto 5) = dblk(15-I)(282 downto 256) then
							--- Hit case
							case address_in(4 downto 2) is
								when "111" => dblk(15-I)(255 downto 224) <= data_in; DHc<='1';--word 7
								when "110" => dblk(15-I)(223 downto 192) <= data_in; DHc<='1';--word 6
								when "101" => dblk(15-I)(191 downto 160) <= data_in; DHc<='1';--word 5
								when "100" => dblk(15-I)(159 downto 128) <= data_in; DHc<='1';--word 4
								when "011" => dblk(15-I)(127 downto 96) <= data_in; DHc<='1';--word 3
								when "010" => dblk(15-I)(95 downto 64) <= data_in; DHc<='1';--word 2
								when "001" => dblk(15-I)(63 downto 32) <= data_in; DHc<='1';--word 1
								when others=> dblk(15-I)(31 downto 0) <= data_in; DHc<='1';--word 0
							end case;
							exit;
						else
							--- Miss case
							DHc<='0';
						end if;
					end loop;
					address_out <= address_in;
					data_out <= data_in;
				end if;
			end if;

			--Transfer
			if opType="10" then
				-- ICahce
				if cacheType='0' then
					iaddress_in:= conv_integer(address_in(9 downto 5));
					iblk(iaddress_in)(282 downto 256) <= address_in(31 downto 5);
						case stateTrans is
							when "000" => iblk(iaddress_in)(31 downto 0) <= data_in;
							when "001" => iblk(iaddress_in)(63 downto 32) <= data_in;
							when "010" => iblk(iaddress_in)(95 downto 64) <= data_in;
							when "011" => iblk(iaddress_in)(127 downto 96) <= data_in;
							when "100" => iblk(iaddress_in)(159 downto 128)<= data_in;
							when "101" => iblk(iaddress_in)(191 downto 160)<= data_in;
							when "110" => iblk(iaddress_in)(223 downto 192)<= data_in;
							when others => iblk(iaddress_in)(255 downto 224)<= data_in;trasn_out<='1';
						end case;
				end if;
				-- DCache
				if cacheType='1' then
					daddress_in:= conv_integer(address_in(8 downto 5));
					dblk(daddress_in)(282 downto 256) <= address_in(31 downto 5);
						case stateTrans is
							when "000" => dblk(daddress_in)(31 downto 0) <= data_in;
							when "001" => dblk(daddress_in)(63 downto 32) <= data_in;
							when "010" => dblk(daddress_in)(95 downto 64) <= data_in;
							when "011" => dblk(daddress_in)(127 downto 96) <= data_in;
							when "100" => dblk(daddress_in)(159 downto 128) <= data_in;
							when "101" => dblk(daddress_in)(191 downto 160) <= data_in;
							when "110" => dblk(daddress_in)(223 downto 192) <= data_in;
							when others => dblk(daddress_in)(255 downto 224)<= data_in;trasn_out<='1';
						end case;
				end if;
			end if;
	end process;
end architecture;