inclass\_3\_4
================

# Q1: Reducing training set

*We originally set the proportion of the training set to be .8 — what
happens to performance when we set it at .2? Re-run all the code after
that point (with smoothing)*

Our accuracy, recall, and F1 score decrease slightly under a smaller
training set, while the precision increases by a hair (from 0.9599589 to
0.963013).

# Q2: Priors in Naive Bayes

*Read the help file about textmodel\_nb . What does the “prior” argument
do in Naive Bayes? What is the default value for this argument in
quanteda?*

The prior distributions are our assigned prior probability that a
document is in a specific class. The default is a uniform distribution –
for n classes, the prior probability that doc A is in any class is
1/n. Other choices set initial probabilities based on the frequency of
documents in the classes in the training set (.6 documents are class A,
.4 documents are class B, and we could set the prior distribution to be
p(A)=.6 and p(B) = .4 for all docs). We could also whittle this down to
the proportion of total features as our prior (.7 of all features are in
class A, .3 are in B, thus probabilities for each class are assigned as
such).

# Q3: Document frequency vs. uniform

# Looking at the results of the code, were you right?

Since the dataset is \~.6 sports and \~.4 crime, we would theoretically
expect a document frequency prior to lead to better performance than a
purely .5/.5 prior for p(A)/p(B), but .6/.4. is also not that far off
from .5/.5 so the effect is likely very small.

*With uniform* Baseline Accuracy: 0.5944478 Accuracy: 0.9523235 Recall:
0.9522843 Precision: 0.9670103 F1-score: 0.9595908

*With docfreq* Baseline Accuracy: 0.5944478 Accuracy: 0.954134 Recall:
0.9583756 Precision: 0.9642492 F1-score: 0.9613035

The changes are very slight across the board–accuracy/recall/F1 all
increase by a small amount, and recall decreases a bit (which I did not
actually expect).
