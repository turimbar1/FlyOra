-- BetwenStr function and accompanying tests
create or replace function HR.betwnstr( a_string varchar2, a_start_pos integer, a_end_pos integer ) return varchar2
is
begin
  if a_start_pos = 0 then
    return substr( a_string, a_start_pos, a_end_pos - a_start_pos);
  else
    return substr( a_string, a_start_pos, a_end_pos - a_start_pos + 1);
  end if;
end;
/

create or replace package HR.test_betwnstr as
  
  -- %suite(Between string function)
  
  -- %test(Returns substring from start position to end position)
  procedure basic_usage;
  
  -- %test(Returns substring when start position is zero)
--   procedure zero_start_position;
  
  -- %test(More between function)
  procedure ut_betwn;
  
end;
/
  
create or replace package body HR.test_betwnstr as
  
  procedure basic_usage is
  begin
    ut.expect( betwnstr( '1234567', 2, 5 ) ).to_equal('2345');
  end;
  
  procedure zero_start_position is
  begin
    ut.expect( betwnstr( '1234567', 0, 5 ) ).to_equal('12345');
  end;
    
   PROCEDURE ut_betwn IS
   BEGIN
    ut.expect(betwnstr ('this is a string', 3, 7), 'Typical Valid Usage').to_equal('is is');
    ut.expect(betwnstr ('this is a string', -3, 7), 'Test Negative Start').to_equal('ing');
    ut.expect(betwnstr ('this is a string', 3, 1), 'Start Bigger than End').to_be_null();
   END;
end;
/
  
-- Password Strength utPLSQL examples and accompanying tests
  
  
create or replace package HR.bl_user_registration as
    function validate_password_strength(in_password in varchar2)
    return boolean;
end bl_user_registration;
/
  
create or replace
package body HR.bl_user_registration as
 
   -- A valid password needs an uppercase and lowercase character, a digit and to be between 4 and 20 characters long
 
   -- Example tests from https://apexplained.wordpress.com/2013/07/14/introducing-unit-tests-in-plsql-with-utplsql/
 
  function validate_password_strength(in_password in varchar2)
  return boolean is
  begin
    if not regexp_like(in_password, '[[:digit:]]') then
      return false;
    end if;
   
    if not regexp_like(in_password, '[[:lower:]]') then
      return false;
    end if;
   
    if not regexp_like(in_password, '[[:upper:]]') then
      return false;
    end if;
   
    if not regexp_like(in_password, '[@#$%]') then
      return false;
    end if;
 
    if length(in_password) is null or length(in_password)
    not between 4 and 20 then
      return false;
    end if;
 
   
    return true;
  end validate_password_strength;
   
end bl_user_registration;
/
  
create or replace package HR.test_bl_user_registration as
   
 -- %suite(Password tests)
   
  -- %test(validates strong passwords)
  procedure validate_strong_passwords;
  -- %test(validates missing characters)
  procedure validate_missing_characters;
  -- %test(validates boundary cases)
  procedure validate_boundaries;
    
   
 -- source: https://apexplained.wordpress.com/2013/07/14/introducing-unit-tests-in-plsql-with-utplsql/
end test_bl_user_registration;
/
  
create or replace package body HR.test_bl_user_registration as
 
       procedure validate_strong_passwords as
    begin
        ut.expect(bl_user_registration.validate_password_strength('ABCdef123#'), 'ABCdef123# is a strong password').to_(equal(true));
        ut.expect(bl_user_registration.validate_password_strength('%abc1B2CD'), '%abc1B2CD is a strong password').to_(equal(true));
        ut.expect(bl_user_registration.validate_password_strength('%abc1B2CD'), '%abc1B2CD is a stronger password').to_(equal(true));
    end validate_strong_passwords;
 
 
    procedure validate_missing_characters as
    begin
        ut.expect(bl_user_registration.validate_password_strength('Abcdefg#'), 'Abcdefg# misses a digit character').to_(equal(false));
        ut.expect(bl_user_registration.validate_password_strength('ABCD1234$'), 'ABCD1234$ misses a lowercase character').to_(equal(false));
        ut.expect(bl_user_registration.validate_password_strength('abcd1234@'), 'abcd1234@ misses an uppercase character').to_(equal(false));
        ut.expect(bl_user_registration.validate_password_strength('ABcd1234'), 'ABcd1234 misses a special character').to_(equal(false));
    end validate_missing_characters;
 
 
    procedure validate_boundaries as
    begin
        ut.expect(bl_user_registration.validate_password_strength('Ab1%'), 'Password is the minimum valid length').to_(equal(true));
        ut.expect(bl_user_registration.validate_password_strength('A1%'), 'Password is too short').to_(equal(false));
        ut.expect(bl_user_registration.validate_password_strength('Abcdefghijk12345678@'), 'Password is the maximum valid length').to_(equal(true));
        ut.expect(bl_user_registration.validate_password_strength('Abcdefghijk123456789@'), 'Password is too long').to_(equal(false));
        ut.expect(bl_user_registration.validate_password_strength(''), 'An empty string should return false').to_(equal(false));
 
    end validate_boundaries;
 
  
  
end test_bl_user_registration;
/