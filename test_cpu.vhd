library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity test_cpu is 
end entity;

architecture behav of test_cpu is       

    --Component Declaration of UUT
    component cpu 
    port(
        stateCpu    : in  std_logic;
        ins_in      : in  std_logic_vector(31 downto 0);
        address_in  : in  std_logic_vector(31 downto 0);
        data_in     : in  std_logic_vector(31 downto 0);
        address_out : out std_logic_vector(31 downto 0);
        data_out    : out std_logic_vector(31 downto 0)
    );
    end component;
    
    signal stateCpu      : std_logic;
    signal ins_in        : std_logic_vector(31 downto 0);
    signal address_in    : std_logic_vector(31 downto 0);
    signal address_out   : std_logic_vector(31 downto 0);
    signal data_in       : std_logic_vector(31 downto 0);
    signal data_out      : std_logic_vector(31 downto 0);
    
    begin 
    
        --UUT
        uut: cpu port map(
                stateCpu  => stateCpu,
                ins_in    =>    ins_in,
                address_in   => address_in,
                data_in    => data_in,
                address_out  => address_out,
                data_out     =>data_out 
                );
    
        tb: process
        begin
        
        
        --load values for add ($t3)
        wait for 100 ns;
        stateCpu<='1'; ins_in <= "10001100001010110000000000000000"; data_in<= "00000000000000000000000001100100";--100
        wait for 100 ns;
        --($t2)
        stateCPU<='1'; ins_in <= "10001100001010100000000000000000"; data_in<= "00000000000000000000000000010100";--20
        --ins Add
        wait for 100 ns;
        stateCPU <= '0'; ins_in <= "00000001011010101001100000100000"; 
        wait for 100 ns;
        stateCPU <= '1';address_in <= "00000000000000000000000000000000";
        wait for 100 ns;
        
        --ins NOR
        stateCPU <= '0';
        ins_in <= "00000001011010101001100000010111";
        wait for 100 ns;
        stateCPU <= '1';address_in <= "00000000000000000000000000000011";
        wait for 100 ns;
        
        --ins SLL
        stateCPU <= '0';
        ins_in <= "00000001011010101001100100000000";
        wait for 100 ns;
        stateCPU <= '1';address_in <= "00000000000000000000000000000000";
        wait for 100 ns;
        
        --load values for SW ($t4)
        wait for 100 ns;
        ins_in <= "10001100001011000000000000000000";
        data_in<= "00000000000000000000000001100100";--100
        stateCPU<='1';
        wait for 100 ns;
            
        --ins SW
        stateCPU <= '0';
        ins_in <= "10101101100100110000000001100100";
        wait for 100 ns;
        stateCPU <= '1';address_in <= "00000000001100000000000000000000";
        wait for 100 ns;
        
        --load values for beq ($s5)
        wait for 100 ns;
        ins_in <= "10001100001101010000000000000000";
        data_in<= "00000000000000000000000001100100";--100
        stateCPU<='1';
        wait for 100 ns;
        --($t2)
        ins_in <= "10001100001011100000000000000000";
        data_in<= "00000000000000000000000001100100";--100
        stateCPU<='1';
        wait for 25 ns;
    
        --ins beq
        wait for 100 ns;
        stateCPU <= '0';
        address_in <= "00000000000000000000000000000000";
        ins_in <= "00010010101011100000000110010000";
        wait for 100 ns;
        stateCPU <= '1';
        wait for 100 ns;
        
            wait;
        end process;
end architecture;
    
    

        
        