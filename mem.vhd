library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Mem is generic ( DATA_WIDTH :integer := 32; ADDR_WIDTH :integer := 10 );
	port(
		addressIn : in std_logic_vector(31 downto 0); --address Input
		data_in : in std_logic_vector(DATA_WIDTH-1 downto 0);
		MemRead : in std_logic;
		MemWrite : in std_logic;
		data_out : out std_logic_vector(DATA_WIDTH-1 downto 0)
	);
end entity;

architecture rtl of Mem is
	--Internal Variables--
	constant RAM_DEPTH :integer := 2**(ADDR_WIDTH);
	type RAM is array (integer range<>) of
	std_logic_vector(DATA_WIDTH-1 downto 0);
	signal mem : RAM (0 to RAM_DEPTH-1):= (others =>(others=>'0'));

		begin
			--Memory Write Block
			MEM_WRITE:
			process (addressIn, data_in, MemWrite)
				variable address1 : std_logic_vector(ADDR_WIDTH-1 downto 0);
				variable index : integer;
				begin

					address1 := addressIn(ADDR_WIDTH-1 downto 0);
					index := conv_integer(address1);
					if( MemWrite='1') then
						mem(100) <= "00000001011010101001100000100000";
						mem(101) <= "00000001011010101001100000010111";
						mem(102) <= "00000001011010101001100100000000";
						mem(103) <= "10101101100100110000000001100100";
						mem(104) <= "00010010101011100000000110010000";
						mem( index) <= data_in;
					end if;
			end process;

			MEM_READ:
			process (addressIn, MemRead)
				variable address1 : std_logic_vector(ADDR_WIDTH-1 downto 0);
				begin

					address1 := addressIn(ADDR_WIDTH-1 downto 0);
					if(MemRead='1') then
						data_out <= mem(conv_integer(address1));
					end if;
			end process;
end architecture;