function [ula_sv] = ULA_sv(theta,M)
% ULA的阵列响应矢量
    m = 0:M-1;
    ula_sv = exp(1i*pi*m*theta).';
end