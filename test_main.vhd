library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity test_main is 
end entity;

architecture behav of test_main is       

    --Component Declaration of UUT
    component main 
    port(
        rst    : in std_logic;
        IW_in  : in std_logic;
        crtl   : in std_logic;
        MW     : in std_logic;
        MWcrtl : in std_logic;
        stateC : in std_logic;
        stateCC: in std_logic;
        dataC  : in std_logic;
        insC   : in std_logic;
        sc     : in std_logic;
        pc_in  : in std_logic_vector( 31 downto 0);
        data   : in std_logic_vector( 31 downto 0);
        ins    : in std_logic_vector( 31 downto 0)
    );
    end component;
    
    signal rst     : std_logic;
    signal IW_in   : std_logic;
    signal crtl    : std_logic;
    signal MW      : std_logic;
    signal MWcrtl  : std_logic;
    signal stateC  : std_logic;
    signal stateCC : std_logic;
    signal dataC   : std_logic;
    signal insC    : std_logic;
    signal sc      : std_logic;
    signal pc_in   : std_logic_vector(31 downto 0);
    signal data    : std_logic_vector(31 downto 0);
    signal ins     : std_logic_vector(31 downto 0);
    
    begin 
    
        --UUT
        uut: main port map(
                rst  => rst,
                IW_in    =>    IW_in,
                crtl   => crtl,
                MW    => MW,
                MWcrtl  => MWcrtl,
                stateC  => stateC,
                stateCC    =>    stateCC,
                dataC   => dataC,
                insC    => insC,
                sc => sc,
                pc_in     =>pc_in,
                data   => data,
                ins    => ins
                );
    
        tb: process
        begin
    
            wait for 100 ns;
            MW<='1'; MWcrtl<='0';
            wait for 100 ns;
            MWcrtl<='1';
            wait for 100 ns;
            dataC<='0'; stateCC<='0';insC<='0';
            stateC<='1';ins <= "10001100001010110000000000000000"; data<= "00000000000000000000000001100100";--100
            wait for 100 ns;
            dataC<='0'; stateCC<='0';insC<='0';
            stateC<='1';ins <= "10001100001010100000000000000000"; data<= "00000000000000000000000000010100";--100
            wait for 100 ns;
            dataC<='0'; stateCC<='0';insC<='0';
            stateC<='1';ins <= "10001100001011000000000000000000"; data<= "00000000000000000000000001100100";--100
            wait for 100 ns;
            dataC<='0'; stateCC<='0';insC<='0';
            stateC<='1';ins <= "10001100001101010000000000000000"; data<= "00000000000000000000000001100100";--100
            wait for 100 ns;
            dataC<='0'; stateCC<='0';insC<='0';
            stateC<='1';ins <= "10001100001011100000000000000000"; data<= "00000000000000000000000001100100";--100
            wait for 100 ns;
            dataC<='1'; stateCC<='1';insC<='1';
            wait for 100 ns;
            rst<='1'; 
            pc_in <="00000000000000000000000001100100";IW_in <='1';crtl<='0';sc<='0';
            wait for 10 ns;
            rst <='0';IW_in <='0';
            wait for 250 ns;
            crtl<='1'; sc <='1';
            wait for 100000 ns;
            rst<='1';
            wait for 100 ns;
    
    
        wait;
        end process;
end architecture;
    