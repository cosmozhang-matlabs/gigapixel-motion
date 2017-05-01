function [endx, endval, k]=steepest(f, xs, x0, e)

n = size(xs,1);
syms m; % learning rate

df = xs;
for i = 1:n
    df(i) = diff(f,xs(i));
end

flag=1;  %循环标志
k=0; %迭代次数
while(flag)
    df_temp = subs(df,xs,x0);
    nor=norm(df_temp); %范数
    if(nor>=e)
        x_temp = x0 - m * df_temp;
        f_temp = subs(f, xs, x_temp);
        h = diff(f_temp,m);
        m_temp = solve(h);
        x0 = x0 - m_temp * df_temp;
        k=k+1;
    else
        flag=0;
    end
end

endx = double(x0);
endval = double(subs(f,xs,x0));

end