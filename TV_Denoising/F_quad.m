function [ m, new_u] = F_quad(z, u,i)

    x = P_quad(z  -  u,i);
   
    new_u = u + (x  -  z);

    m = new_u + x;

end