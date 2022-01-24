%% Stability Alghoritm %%

function Stability=Explicit_Stability(i_start,i_step,i_end,n_start,n_step,n_end)
count=1;                               % this count is needed for the break
Stability(:,1)=(i_start:i_step:i_end)';% this represents our M combinations         

for i=i_start:i_step:i_end             % starting the loops now. With i...
    for n=n_start:n_step:n_end         % for n...
    [d1,d2,d3]=d_calc(i,n);            % get the d1,d2 and d3 vecs for our A Matrix                                          
    [A]=tridiag(d1,d2,d3);             % transform them into the tridiagonal structure
    EV=eig(A);                         % calculate eigenvalues
    Max_EV=max(abs(EV));               % we are only interested in the maximum EV of the EV-vec
    norm_a=norm(A,inf);                % also we need the 2nd norm for the sufficient conditon
            if abs(Max_EV) <1 && norm_a<1   % this is our stability condition vice versa since we start from the bottom (with the highest EV)
                Stability(count,2)=n;       % cunts the N were this conditon will be satisfied
                count=count+1;              % if it is satisfied we check the next row
                n_start=n;                  % if the ev/row gets just as smaller as 1
                break                       % we break the loop since since we're only interested in the 'frontier cases'
            end                             % note that we just store that value were the ev jus gets as small as 1
    end
end

loop_size=size(Stability);                  % predefiniton for efficiency


for i=1:1:loop_size                                                          % loop to calculate the MxN and absolute errors for the logarithmic plots
Stability(i,3)=Stability(i,1).*Stability(i,2);                               % simple MxN combination for plotting the log plots
[~, ~,~,~, ~,ME_Put_2D, ME_Put_3D]=Explicit_EuroPut(1200,1,Stability(i,1),Stability(i,2));  % calculate the maximum error..
Stability(i,4)=ME_Put_2D;  
Stability(i,5)=ME_Put_3D; % store them
end
end

