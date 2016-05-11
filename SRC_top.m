function SRC_top(dataset, N_trn, lambda)
% function SRC_top(dataset, N_trn, lambda)
% Description       : SRC 
%     INPUT: 
%       dataset: name of the dataset stored in 'data', excluding '.mat'
%       N_trn: number of training images per class 
%       lambda : regularization parameter lambda     
% -----------------------------------------------
% Author: Tiep Vu, thv102@psu.edu, 5/11/2016
%         (http://www.personal.psu.edu/thv102/)
% -----------------------------------------------
    addpath('utils');
    addpath('SRC');
    addpath('build_spams');
    %% ========= Test mode ==============================
    if nargin == 0 
        dataset = 'myARgender';
        N_train = 40;
        lambda = 0.001;
    end 
    %%
    t = getTimeStr();
    [dataset, Y_train, Y_test, label_train, label_test] = train_test_split(...
        dataset, N_train);
    %% output file 
    if ~exist('results', 'dir')
        mkdir('results');
    end 
    if ~exist(fullfile('results', 'SRC'), 'dir')
        mkdir('results', 'SRC');
    end 
    fn = fullfile('results', 'SRC', strcat(dataset, '_N_', num2str(N_train), ...
        '_l_', num2str(lambda), '_', t, '.mat'));
    disp(fn);
    %%
    opts.lambda   = lambda;
    opts.verbal   = 0;
    opts.max_iter = 300;
    %%
    train_range = label_to_range(label_train);
    pred        = SRC_pred(Y_test, Y_train, train_range, opts);
    
    acc         = double(sum(pred == label_test))/numel(pred);
    disp(['acc = ', num2str(acc)]);
    disp(fn);    
    save(fn, 'acc');
end 
