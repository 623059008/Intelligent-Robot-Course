function likelihood()
clc
clear
close all

zt = 1:0.001:10;
q = likelihood_field_model(zt);
plot(zt, q);

    function [q]=likelihood_field_model(zt)
        sigma_hit=1;
        z_hit=5;
        z_max=0.8;
        z_rand=0.7;
        z_MAX = 10;
        q = ones(1, length(zt));
        
        for j = 1:length(zt)
            xt = 0;
            yt = zt(j);
            dist = minDist(xt, yt);
            q(j) = z_hit * p_hit(dist, 0, sigma_hit);
        end
        q = q + z_max * p_max(zt, z_MAX) + z_rand * p_rand(zt, z_MAX);
        
        function dist = minDist(xt, yt)
            ta = pdist2([xt yt], [1 2]);
            tb = pdist2([xt yt], [0.85 2.7]);
            if (yt < 6)
                tc = pdist2([xt yt], [-1.5 6]);
            elseif (yt > 8)
                tc = pdist2([xt yt], [-1.5 8]);
            else
                tc = xt + 1.5;
            end
            dist = min([ta tb tc]);
        end
        
        function [p_hit]=p_hit(z_tk,z_tk_star,sigma_hit)
            p_hit = (1/sqrt(2*pi*sigma_hit.^2))*(exp(-0.5*(z_tk-z_tk_star).^2/(sigma_hit.^2)));
        end
        
        function [p_max]=p_max(z_tk,z_MAX)
            p_max = zeros(1, length(z_tk));
            for i = 1:length(z_tk)
                if (z_tk(i) >= z_MAX*0.98 && z_tk(i) <= z_MAX)
                    p_max(i) = 1;
                end
            end
            
        end
        
        function [p_rand] = p_rand(z_tk,z_MAX)
            p_rand = zeros(1, length(z_tk));
            for i = 1:length(z_tk)
                if (z_tk(i) >= 0 && z_tk(i) <= z_MAX)
                    p_rand(i) = 1 / z_MAX;
                end
            end  
        end
    end

end
