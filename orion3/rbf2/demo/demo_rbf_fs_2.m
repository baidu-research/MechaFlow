function [mydemo, cleanup] = demo_rbf_fs_2
%
% Demo of regularised forward selection of RBFs.
%

% Initialise number of chunks in mydemo.
n = 0;

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{
              'This is the demo for the rbf_fs_2 method.', ...
              '-----------------------------------------', ...
              '', ...
              'rbf_fs_2 is an algorithm for regression and classification', ...
              'which forwardly selects radial basis functions to generate', ...
              'the data model. It includes optional ridge regression to', ...
              'help control model complexity and can automatically estimate', ...
              'the regularisation parameter.'}}, ...
  'commands', '', ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'First, let''s try the method on a relatively easy 1D problem,', ...
              'the ''hermite'' data set. We''ll first get an instance of', ...
              'a training set for that problem and take a look at it.'}}, ...
  'commands', {{ ...
              '[x, y, dconf] = get_data(''hermite'');', ...
              'fig = get_fig(''rbf_fs_2 demo'');', ...
              'hold off', ...
              'plot(x, y, ''r*'')', ...
              '%set(gca, ''XLim'', [dconf.x1 dconf.x2])', ...
              '%set(gca, ''YLim'', [floor(min(y)) ceil(max(y))])', ...
              '%set(gca, ''XTick'', dconf.x1:dconf.x2)', ...
              '%set(gca, ''YTick'', floor(min(y)):ceil(max(y)))', ...
              '%xlabel(''x'', ''FontSize'', 16)', ...
              '%ylabel(''y'', ''FontSize'', 16, ''Rotation'', 0)'}}, ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'We''ll also get an uncorrupted (zero noise), ordered test set', ...
              'of 400 samples which we can use to judge the accuracy of', ...
              'rbf_fs_2 after learning from the training set.'}}, ...
  'commands', {{ ...
              'dconf.std = 0;', ...
              'dconf.ord = 1;', ...
              'dconf.p = 400;', ...
              '[xt, yt] = get_data(dconf);', ...
              'hold on', ...
              'plot(xt, yt, ''b-'', ''LineWidth'', 2)'}}, ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'Now we''ll run the method on the training set (x,y). rbf_fs_2', ...
              'will return the centres (c), radii (r) and weights (w) of an', ...
              'RBF network. For now, we''ll let rbf_fs_2 choose default values', ...
              'for all its control parameters. These parameters are set by', ...
              'a third input argument to the routine, a structure with named', ...
              'fields corresponding to each parameter. Omitting this argument', ...
              'causes the method to use default values.', ...
              '', ...
              'This may take a few seconds.'}}, ...
  'commands', '[c, r, w] = rbf_fs_2(x, y);', ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'To make predictions, we use rbf_dm to get the design matrix', ...
              'of the test set and then multiply this by the weights to get', ...
              'the model''s prediction over the test set inputs (xt).'}}, ...
  'commands', {{ ...
              'Ht = rbf_dm(xt, c, r);', ...
              'ft = Ht * w;', ...
              'plot(xt, ft, ''m-'', ''LineWidth'', 2)'}}, ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'The prediction error is obtained by comparing ft and yt.', ...
              'We''ll remember this number for comparison later.', ...
              '', ...
              'The fit doesn''t look too great, so we might want to try to', ...
              'improve the performance by changing some of the parameters', ...
              'controlling rbf_fs_2, instead of lazily allowing it to operate', ...
              'with defaults.'}}, ...
  'commands', {{ ...
              'err1 = (ft - yt)'' * (ft - yt);', ...
              'disp(err1)'}}, ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'By default rbf_fs_2 uses RBFs with widths equal to the spread', ...
              'of the inputs in each dimension, which is pretty large. Large', ...
              'RBFs can often work well for multidimensional problems but are', ...
              'typically less sucessful for simple 1D problems like ''hermite''.', ...
              '', ...
              'To try to improve matters we''ll decrease the radius to a size', ...
              'estimated from an eyeball inspection of the data.'}}, ...
  'commands', 'conf.rad = 1;', ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'Now we''re ready to try again, this time with the conf structure', ...
              'specifying a radius size different from the default.', ...
              '', ...
              'Once again, the next step may take a few seconds to complete.'}}, ...
  'commands', '[c, r, w, info] = rbf_fs_2(x, y, conf);', ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'Now let''s calculate the predictions and plot them in the figure', ...
              '(look for the red curve).'}}, ...
  'commands', {{ ...
              'Ht = rbf_dm(xt, c, r);', ...
              'ft = Ht * w;', ...
              'err2 = (ft - yt)'' * (ft - yt);', ...
              'plot(xt, ft, ''r-'', ''LineWidth'', 2)'}}, ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', 'Did we improve on the first attempt? Probably very significantly so.', ...
  'commands', {{ ...
              'disp(err1)', ...
              'disp(err2)'}}, ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'The previous example was a simple 1D problem. The next (and last) example', ...
              'involves a more challenging data set for which changes to the default', ...
              'configuration once again improve performance, though not as dramatically.'}}, ...
  'commands', 'close(fig)', ...
  'question', 'Do you want to see the next example?', ...
  'optional', {{'yes', 'no'}});

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'The data set we''re going to use is also available through the', ...
              'get_data routine. It''s name is ''friedman''. The input space is', ...
              'four-dimensional, there are 200 samples, and a lot of noise is', ...
              'added to the training set outputs.', ...
              '', ...
              'So first, let''s get our train and test sets.'}}, ...
  'commands', {{ ...
              '[X, y, dconf] = get_data(''friedman'');', ...
              'dconf.std = 0;', ...
              'dconf.p = 1000;', ...
              '[Xt, yt] = get_data(dconf);'}}, ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'For this problem it''s customary to scale the test set error', ...
              'by the total variance, so before we do anything else, let''s', ...
              'just calculate that in case we forget.'}}, ...
  'commands', 'scale = sum((yt - sum(yt)/dconf.p).^2);', ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'Now, as before, we''ll first try the algorithm out without', ...
              'altering its default configuration.', ...
              '', ...
              'The next step may take a little while. For example, it takes', ...
              'about 5 seconds on my 233MHz Pentium I laptop. Information', ...
              'about the time and FLOPS consumed by the method is available', ...
              'from info, the fourth output argument.'}}, ...
  'commands', {{ ...
              '[C, R, w, info] = rbf_fs_2(X, y);', ...
              'disp(info.stats.comps) % FLOPS', ...
              'disp(info.stats.ticks) % time in seconds'}}, ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'Now let''s see how well we can predict the test set by evaluating the', ...
              'scaled sum of square errors. For comparison, a method which simply', ...
              'predicted an output of zero for any input would score exactly 1.0.', ...
              '', ...
              'The situation can be improved by changing rbf_fs_2''s configuration', ...
              'in two ways, as we will now show.'}}, ...
  'commands', {{ ...
              'Ht = rbf_dm(Xt, C, R);', ...
              'ft = Ht * w;', ...
              'err1 = (ft - yt)'' * (ft - yt) / scale;', ...
              'disp(err1)'}}, ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'Often multi-dimensional and noisy data sets are best tackled with', ...
              'surprisingly large RBFs. For this ''friedman'' problem a radius of', ...
              'around 4 usually works best, even though this exceeds the range of any', ...
              'individual input dimension (the inputs are all normalised to range from', ...
              '-1 to +1 in each dimension).', ...
              '', ...
              'To hedge our bets a little, we''ll supply two centres at each input point,', ...
              'one with a radius of 5 and another with radius 3. The algorithm can choose', ...
              'which of the two it likes best. Note that before we setup the new conf', ...
              'structure we should be careful to clear away the previous one.'}}, ...
  'commands', {{ ...
              'clear conf', ...
              'conf.cen = [X X];            % centres', ...
              'R3 = 3 * ones(4,size(X,2));  % small radii', ...
              'R5 = 5 * ones(4,size(X,2));  % big radii', ...
              'conf.rad = [R3 R5];'}}, ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'Now let''s try that and work out the scaled prediction error again.', ...
              'It should have decreased compared to the first attempt.', ...
              '', ...
              'This may take a few seconds.'}}, ...
  'commands', {{ ...
              '[C, R, w] = rbf_fs_2(X, y, conf);', ...
              'Ht = rbf_dm(Xt, C, R);', ...
              'ft = Ht * w;', ...
              'err2 = (ft - yt)'' * (ft - yt) / scale;', ...
              'disp(err1)', ...
              'disp(err2)'}}, ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'The second change we can make to the algorithm is to regularise as', ...
              'well as forward select: further insurance against overfitting. To', ...
              'turn regularisation on we set conf.reest to 1 which instructs the', ...
              'algorithm to re-estmate the optimal regularisation parameter between', ...
              'each selection. This time we don''t clear conf because we want to keep', ...
              'the large radii we setup in a previous step.', ...
              '', ...
              'This may take a few seconds.'}}, ...
  'commands', {{ ...
              'conf.reest = 1;', ...
              '[C, R, w] = rbf_fs_2(X, y, conf);', ...
              'Ht = rbf_dm(Xt, C, R);', ...
              'ft = Ht * w;', ...
              'err3 = (ft - yt)'' * (ft - yt) / scale;'}}, ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', {{ ...
              'Finally we can compare the three prediction errors from running the', ...
              'method with (1) all its defaults, (2) large radii and (3) large radii', ...
              'and regularisation.'}}, ...
  'commands', {{ ...
              'disp(err1)', ...
              'disp(err2)', ...
              'disp(err3)'}}, ...
  'question', '', ...
  'optional', '');

n = n + 1;
mydemo(n) = struct( ...
  'comments', 'End of rbf_fs_2 demo.', ...
  'commands', '%clear conf', ...
  'question', '', ...
  'optional', '');

% Define the command(s) necessary to cleanup after the demo (e.g. close figures).
cleanup = 'if exist(''fig'', ''var'') if ~isempty(find(findobj(''type'',''figure'') == fig)) close(fig); end; end';