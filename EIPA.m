clear all; close all;

global C

C.q_0 = 1.60217653e-19;             % electron charge
C.hb = 1.054571596e-34;             % Dirac constant
C.h = C.hb * 2 * pi;                    % Planck constant
C.m_0 = 9.10938215e-31;             % electron mass
C.kb = 1.3806504e-23;               % Boltzmann constant
C.eps_0 = 8.854187817e-12;          % vacuum permittivity
C.mu_0 = 1.2566370614e-6;           % vacuum permeability
C.c = 299792458;                    % speed of light

nx = 50;
ny = 50;

G = sparse(nx*ny,nx*ny);
B = zeros(1, nx*ny);

alpha = 1;

for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        nxm = j + (i - 2)*ny;
        nxp = j + i *ny;
        nym = (j - 1) + (i - 1)*ny;
        nyp = (j + 1) + (i - 1)*ny;
        
        %boundary conditions
        if( i == 1)
            G(n,:) = 0;
            G(n, n) = 1;
        elseif ( j == 1)
            G(:,n) = 0;
            G(n,n) = 1;
        elseif (i == nx)
            G(n,:) = 0;
            G(n,n) = 1;
        elseif (j == ny)
            G(:,n) = 0;
            G(n,n) = 1;
        else
          G(n,n) = -4;  
          
          if(i>10 && i < 20)
              if( j>10 && j<20)
                  G(n,n) = -2;
              end
          end
          G(n,nxm) = 1;
          G(n,nxp) = 1;
          G(nyp,n) = 1;
          G(nym,n) = 1;
        end
      end 
end

[E,D] = eigs(G, 9, 'SM');

for k = 1:9
for i=1:nx
   for j=1:ny
        n = j + (i-1)*ny;
        Emap(k,i,j) = (E(n,k));
   end
end
end

figure(1)
spy(G);
figure(2)
for k = 1:9
subplot(3,3,k)
temp = squeeze(Emap(k,:,:));
surf(temp,'linestyle','none');
end    
        