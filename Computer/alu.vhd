library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity alu is
	port (ALU_Sel    : in std_logic_vector(2 downto 0);
	      A          : in std_logic_vector(7 downto 0);
	      B          : in std_logic_vector(7 downto 0);
	      NZVC       : out std_logic_vector(3 downto 0);
	      ALU_Result : out std_logic_vector(7 downto 0));
end entity;

architecture alu_arch of alu is
	
	

	begin

		ALU_PROCESS : process (A, B, ALU_SEL)
		   variable Sum_uns : unsigned(8 downto 0);
		   
		   begin
			if (ALU_Sel = "000") then --ADDITION
			   ---SUM CALCULATION----------------------------------------
			   Sum_uns := unsigned('0'& A)+ unsigned('0'& B);
			   ALU_Result <= std_logic_vector(Sum_uns(7 downto 0));

			   ---NEGATIVE FLAG (N)--------------------------------------
			   NZVC(3) <= Sum_uns(7);

			   ---Zero Flag (Z)------------------------------------------
			   if (Sum_uns(7 downto 0) = x"00") then
				NZVC(2) <= '1';
			   else
				NZVC(2) <= '0';
			   end if;
			
			   ---OVERFLOW FLAG (V)--------------------------------------
			   if ((A(7) = '0' and B(7) = '0' and Sum_uns(7) = '1') or
			       (A(7) = '1' and B(7) = '1' and Sum_uns(7) = '0')) then
				NZVC(1) <= '1';
			   else
				NZVC(1) <= '0';
			   end if;

			   ---Carry Flag (C)-----------------------------------------
			   NZVC(0) <= Sum_uns(8);
			elsif (ALU_Sel = "001") then --SUBTRACTION
			   ---SUBTRACTION CALCULATION--------------------------------
			   Sum_uns := unsigned('0'& A)- unsigned('0'& B);
			   ALU_Result <= std_logic_vector(Sum_uns(7 downto 0));

			   ---NEGATIVE FLAG (N)--------------------------------------
			   NZVC(3) <= Sum_uns(7);

			   ---Zero Flag (Z)------------------------------------------
			   if (Sum_uns(7 downto 0) = x"00") then
				NZVC(2) <= '1';
			   else
				NZVC(2) <= '0';
			   end if;

			   ---OVERFLOW FLAG (V)--------------------------------------
			   if ((A(7) = '0' and B(7) = '0' and Sum_uns(7) = '1') or
			       (A(7) = '1' and B(7) = '1' and Sum_uns(7) = '0')) then
				NZVC(1) <= '1';
			   else
				NZVC(1) <= '0';
			   end if;

			   ---Carry Flag (C)-----------------------------------------
			   NZVC(0) <= Sum_uns(8);
			end if;
		end process;
	NZVC <= A(3 downto 0);
	ALU_Result <= B;

end architecture;

