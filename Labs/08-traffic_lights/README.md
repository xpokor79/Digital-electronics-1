## Lab8 Simulations 

# Traffic lights
![Trafic_lights](../Screens/Lab8_traffic_lights.png)

# Reset
![Lab8_reset](../Screens/Lab8_reset.png)

## Top level
![Lab8_top](../Screens/Lab8_top_level.png)

## State diagram
![State_diagram](../Screens/Lab8_state_diagram.png)
Je-li to nutné, tak by tam měly být šipky ukazující z daného stavu na tentýž stav, když s_count < c_1sec (příp. c_5sec)
## User defined data type
Examples: 
```javascript
TYPE state IS (idle, forward, backward, stop); 
TYPE color IS (red, green, blue, white, black); 
TYPE my_integer IS RANGE -32 TO 32; 
TYPE student_grade IS RANGE 0 TO 100; 
TYPE natural IS RANGE 0 TO +2147483647; 
TYPE bit IS ('0', '1'); 
TYPE my_logic IS ('0', '1', 'Z'); 

TYPE birthday IS RECORD 
  day: INTEGER RANGE 1 TO 31; 
  month: month_name; – month_name datatype should be predefined 
END RECORD; 
```
