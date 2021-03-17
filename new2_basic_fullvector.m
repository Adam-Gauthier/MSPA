close all
clear all
clc
% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

ref_ind = linspace(3.305,3.44,10);           % Ridge half-width
for index=1:10
% Refractive indices:
n1 = 3.34;          % Lower cladding
%n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

n2=ref_ind(index);
[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rw,side,dx,dy); 

% First consider the fundamental TE mode:

[Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');

fprintf(1,'neff = %.6f\n',neff);

for index_2=1:nmodes
    
    %figure(ii);
    figure(index);
    subplot(121);
    contourmode(x,y,Hx(:,:,index_2));
    title(strcat('Hx (TE mode)',num2str(neff))); xlabel('x'); ylabel('y');
    xlim([0 2.5]);ylim([0 3.8]);
    for v = edges, line(v{:}); end

    subplot(122);
    contourmode(x,y,Hy(:,:,index_2));
    title(strcat('Hy (TE mode)',num2str(neff))); xlabel('x'); ylabel('y');
    xlim([0 2.5]);ylim([0 3.8]);
    for v = edges, line(v{:}); end

end

end