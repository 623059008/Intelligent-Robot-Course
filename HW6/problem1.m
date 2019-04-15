close all;
clc;
clear;



data = beam_range_finder_model(300, 1000);
%fplot(data, [0, 500]);


function [q] = beam_range_finder_model(zt, K)
    noise = 10;
    z_tk_star = zt;
    z_tk = z_tk_star + noise;
    sigma_hit = 13;
    lambda_short = 0.03;
    z_hit = 0.3;
    z_short = 0.15;
    z_MAX = 500;
    z_max = 0.35;
    z_rand = 0.2;

    q=@(z_tk) z_hit * p_hit(z_tk, z_tk_star, sigma_hit, z_MAX) + z_short * p_short(z_tk, z_tk_star, lambda_short) + z_max * p_max(z_tk, z_MAX) + z_rand * p_rand(z_tk, z_MAX);
    fplot(q, [0, 500]);
    
    Y = zeros(1,K);
    for i = 1:K
        pro = rand();
        y = 500 * rand();
        while pro > q(y)
            pro = rand();
            y = 500 * rand();
        end
        disp(i);
        Y(i) = q(y);
    end
    X = 1:K;
    scatter(X,Y);
    
    function [p_hit] = p_hit(z_tk,z_tk_star, sigma_hit, z_MAX)
        if z_tk < 0 || z_tk > z_MAX
            p_hit = 0;
        else
           N = @(z_tk, z_tk_star, sigma_hit)1/sqrt(2 * pi * (sigma_hit.^2)) * exp(-0.5 * ((z_tk - z_tk_star).^2) / ((sigma_hit).^2) ); 
           eta = integral(@(z_tk)N(z_tk, z_tk_star, sigma_hit), 0, z_MAX);
           p_hit = 1/eta * N(z_tk, z_tk_star, sigma_hit);
        end
    end

    function [p_short] = p_short(z_tk, z_tk_star, lambda_short)
        if 0 <= z_tk && z_tk <= z_tk_star
            x = 1 / (1 - exp(-lambda_short * z_tk_star));
            p_short = x * lambda_short * exp(-lambda_short * z_tk);
        else
            p_short = 0;
        end
    end

    function [p_max] = p_max(z_tk, z_MAX)
        if z_tk == z_MAX
            p_max = 1
        else
            p_max = 0
        end
    end

    function [p_rand] = p_rand(z_tk, z_MAX)
        if 0 <= z_tk && z_tk < z_MAX
            p_rand = 1 / z_MAX
        else
            p_rand = 0
        end
    end
end

