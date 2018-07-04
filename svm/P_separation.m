function [X] = P_separation(Z_minus_U)
    
	global rho
	global lambda
    
    X = (rho/(lambda + rho)) * Z_minus_U ;
 
end
