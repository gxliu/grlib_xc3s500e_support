--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- librerias 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;


entity rom_memory is 
	generic(
		file_size: integer := 38780; --lines
		instructions: integer := 620440/4; -- bin size
		words_x_line: integer := 4	-- number of words (32 bits) per line
	);
	port(
		--clk: in std_logic;
		addr: in std_logic_vector(23 downto 0);
		addr_b: out std_logic_vector(23 downto 0);
		data: inout std_logic_vector(15 downto 0);
		data_b: out std_logic_vector(31 downto 0);
		oen: in std_ulogic;
		writen: in std_ulogic
	);
end rom_memory;

architecture behav of rom_memory is

file infile: text open read_mode is "image.srec";
type file_type is array (0 to instructions-1) of std_logic_vector(31 downto 0);--std_logic_vector(127 downto 0);
type file_type_b is array (0 to file_size-1) of character;--std_logic_vector(127 downto 0);
signal str_file: file_type_b;
signal std_file: file_type;
signal clk: std_logic:='0';


function char_to_slv4(char : character) return std_logic_vector is 
     variable res_slv4: std_logic_vector(3 downto 0);
begin 
case char is 
when ' ' =>    res_slv4:="0000"; 
when '0' =>    res_slv4:="0000"; 
when '1' =>    res_slv4:="0001"; 
when '2' =>    res_slv4:="0010"; 
when '3' =>    res_slv4:="0011"; 
when '4' =>    res_slv4:="0100"; 
when '5' =>    res_slv4:="0101"; 
when '6' =>    res_slv4:="0110"; 
when '7' =>    res_slv4:="0111"; 
when '8' =>    res_slv4:="1000"; 
when '9' =>    res_slv4:="1001"; 
when 'A' =>    res_slv4:="1010"; 
when 'B' =>    res_slv4:="1011"; 
when 'C' =>    res_slv4:="1100"; 
when 'D' =>    res_slv4:="1101"; 
when 'E' =>    res_slv4:="1110"; 
when 'F' =>    res_slv4:="1111"; 
when others => res_slv4:="0000";    --ASSERT (false) REPORT "no hex character read" SEVERITY 
--failure; 
end case; 
return res_slv4; 
end char_to_slv4; 


begin


process begin
wait for 10 ns;
clk<=not clk;
end process;

process 

variable in_line: line;
variable end_line: boolean;
variable n : integer :=0;
variable j : integer :=0;
variable m : integer :=0;
variable char: character;
variable address: std_logic_vector(23 downto 0);
variable address_b: std_logic_vector(21 downto 0);
variable instruction: std_logic_vector(31 downto 0);
begin
---	if (not end_line) then
	address := x"000000";
	for i in str_file'range loop-- file_size--0 to file_size-1
		readline(infile, in_line);

--		for j in 0 to 3 loop
		--- type
		read(in_line, char);
		read(in_line, char);
		-- count
		read(in_line, char);
		read(in_line, char);
		-- address
		read(in_line, char);
		read(in_line, char);		
		read(in_line, char);
		read(in_line, char);
		read(in_line, char);
		read(in_line, char);
		-- data
		j := 0;
		m := 0;
		while m <= 3 loop
			while j <= 7 loop 
				read(in_line, char);
				instruction(31-j*4 downto 28-j*4) := char_to_slv4(char);
				j := j+1;
			end loop;
			std_file(to_integer(unsigned(address))) <= instruction;
			address := address + x"000001";
			m := m+1;
		end loop;


--		end loop;


--			end loop;

--		end loop;
		

--		read(in_line, char);
		--hread(in_line,vector);
--		hread(in_line, vector);
--		hread(in_line, vector);
--		hread(in_line, vector);		addr: in std_logic_vector(23 downto 0);
		--hread(in_line, vector);
--		str_file(j) <= char;
		--data_b <= vector;
--		n:=n+1;
	end loop;
--	addr_b <= address;
--	end if;
	wait;-- until clk='1'; --wait
end process;



process(clk, addr, oen, writen) 
--variable in_line: line;
variable s: character;

variable l : line;
    variable len, nlen, posn : natural;
    variable nl, old_l : line;
    variable str : string (1 to 128);
variable k:integer:= 0;
	begin


	data_b <= std_file(k);
	--untruncated_text_read (infile, str, len);

	--if(not endfile(infile)) then

--	readline(infile, in_line);
--	writeline (output, in_cd                                  line);
--	s := in_line (in_line'left);
--	read(in_line, s);

	--in_line <= str_file(4);
	--write(l, in_line);
	--end if;
--        writeline (output, l);
--	writeline(output, s);
--	write(l, str_file(k));
--        write (l, String'("Hello world!"));
--        writeline (output, l);
	k:=k+1;
        if (clk'event and clk='1') then
		if( oen = '0' and writen = '1') then-- read

			--read(in_line, s)


		end if;
		
		
	end if;

end process;


end behav;










