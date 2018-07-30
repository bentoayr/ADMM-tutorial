# ADMM-tutorial

This repository contains the code for the tutorial presented at the 2018, Open Data Science Conference (ODSC) in Boston.

The slides can be found at  http://www.jbento.info/slides/ADMM_Tutorial_ODSC_2018.pdf

The tutorial covers four different problems. All of them are solved using the Alternating Direction Method of Multipliers (ADMM).

Two of the examples concern convex optimization problems: SVM and Total Variation Denoising.
Two of the examples concern non-convex optimization problems: Circle packing and solving Sudoku puzzles.

The tutorial, and the code, approach the problems from an angle that leads to the math and code being as simple as possible.
The code is not meant for speed, and the variant of the ADMM that we cover is not the fastest possible one.

Please cite this tutorial using the following references.

@article{safavi2018admmtutorial,
title={Networks and large scale optimization}, note={Open Data Science Conference},
author={Safavi, Sam and Bento, Jos{\’e}},
year={2018}
}

@inproceedings{hao2016testing,
title={Testing fine-grained parallelism for the ADMM on a factor-graph},
author={Hao, Ning and Oghbaee, AmirReza and Rostami, Mohammad and Derbinsky, Nate and Bento, Jos{\'e}}, booktitle={Parallel and Distributed Processing Symposium Workshops, 2016 IEEE International}, pages={835--844},
year={2016},
organization={IEEE}
}

@inproceedings{francca2016explicit,
title={An explicit rate bound for over-relaxed ADMM},
author={Fran{\c{c}}a, Guilherme and Bento, Jos{\'e}}, booktitle={Information Theory (ISIT), 2016 IEEE International Symposium on}, pages={2104--2108},
year={2016},
organization={IEEE}
}

@article{derbinsky2013improved,
title={An improved three-weight message-passing algorithm},
author={Derbinsky, Nate and Bento, Jos{\'e} and Elser, Veit and Yedidia, Jonathan S}, journal={arXiv preprint arXiv:1305.1961},
year={2013}
}

@article{bento2018complexity,
title={On the Complexity of the Weighted Fussed Lasso}, author={Bento, Jos{\’e} and Furmaniak, Ralph and Ray, Surjyendu}, journal={arXiv preprint arXiv:1801.04987},
year={2018}
}
