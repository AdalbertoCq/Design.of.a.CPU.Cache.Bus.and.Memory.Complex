library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity test_fsm is 
end entity;

architecture behav of test_fsm is       

    --Component Declaration of UUT
    component fsm 
    port(
        trasn_out : in std_logic;
        reset     : in std_logic;
        clock     : in bit;
        IHc       : in std_logic;
        DHc       : in std_logic;
        cadd      : in std_logic_vector(31 downto 0);
        ins       : in std_logic_vector(31 downto 0);
        pcc       : out std_logic_vector(1 downto 0 );
        ccm       : out std_logic;
        stateCPU  : out std_logic;
        IWrite    : out std_logic;
        IRWrite   : out std_logic;
        madd      : out std_logic_vector(31 downto 0);
        stateTrans: out std_logic_vector(2 downto 0);
        opType    : out std_logic_vector(1 downto 0);
        cacheType : out std_logic;
        MemWrite  : out std_logic;                                
        MemRead   : out std_logic   
    );
    end component;
    
    --Inputs
    signal clock     : bit := '0';
    signal reset     : std_logic := '0';
    signal trasn_out : std_logic := '0';
    signal DHc       : std_logic := '0';
    signal IHc       : std_logic := '0';
    signal cadd      : std_logic_vector(31 downto 0) := (others =>'0');
    signal ins       : std_logic_vector(31 downto 0) := (others =>'0');
    
    --Outputs
    signal pcc          : std_logic_vector(1 downto 0 );
    signal ccm          : std_logic;
    signal stateCPU     : std_logic;
    signal IW           : std_logic;
    signal IRW          : std_logic;
    signal cacheType    : std_logic;
    signal MemWrite     : std_logic;
    signal MemRead      : std_logic;
    signal madd         : std_logic_vector(31 downto 0);
    signal stateTrans   : std_logic_vector(2 downto 0);
    signal opType       : std_logic_vector(1 downto 0);
    
    begin 
    
        --UUT
        uut: fsm port map(
                trasn_out =>trasn_out,
                reset =>reset,
                clock =>clock,
                IHc =>IHc,
                DHc =>DHc,
                cadd =>cadd,
                ins =>ins,
                pcc => pcc,
                ccm =>ccm,
                stateCPU =>stateCPU,
                IWrite =>IW,
                IRWrite =>IRW,
                madd =>madd,
                stateTrans =>stateTrans,
                opType =>opType,
                cacheType =>cacheType,
                MemWrite =>MemWrite,
                MemRead =>MemRead
        );
    
        tb: process
        begin
        
        -------------R Type----------------
            --s0
            wait for 100 ns;
            clock<='1'; reset<='1';
            wait for 100 ns;
            clock<='0'; reset <='0';
            --s1
            wait for 100 ns;
            clock<='1'; IHc<='0';
            wait for 100 ns;
            clock<='0';
            --s2a
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s2b
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s2c
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s2d
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s2e
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s2f
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s2g
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s2h
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s1
            wait for 100 ns;
            clock<='1'; IHc <='1';
            wait for 100 ns;
            clock<='0';
            --s3
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0'; 
            --s4
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0'; 
            --s9
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0'; 
            --s0
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0'; 
            
        -------------Store----------------
            
            --s0
            wait for 100 ns;
            clock<='1'; reset<='1'; ins<="10101101100100110000000001100100";
            wait for 100 ns;
            clock<='0'; reset <='0';
            --s1
            wait for 100 ns;
            clock<='1'; IHc<='1';
            wait for 100 ns;
            clock<='0';
            --s3
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0'; 
            --s4
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0'; 
            --s5
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0'; 
            --s6
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0'; 
            --s9
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0'; 
            --s0
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0'; 
        
        -------------Load----------------
            
            --s0
            wait for 100 ns;
            clock<='1'; reset<='1'; ins<="10001100001101010000000000000000";
            wait for 100 ns;
            clock<='0'; reset <='0';
            --s1
            wait for 100 ns;
            clock<='1'; IHc<='1';
            wait for 100 ns;
            clock<='0';
            --s3
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0'; 
            --s4
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0'; 
            --s7
            wait for 100 ns;
            clock<='1'; DHc <='0';
            wait for 100 ns;
            clock<='0'; 
            --s8a
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s8b
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s8c
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s8d
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s8e
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s8f
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s8g
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s8h
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0';
            --s7
            wait for 100 ns;
            clock<='1'; DHc <='1';
            wait for 100 ns;
            clock<='0';
            --s9
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0'; 
            --s0
            wait for 100 ns;
            clock<='1';
            wait for 100 ns;
            clock<='0'; 
            
            wait;
        end process;
end architecture;
    

        
        