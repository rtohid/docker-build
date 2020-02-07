cmake \
    -DENABLE_METIS=ON                                                           \
    -DENABLE_PARMETIS=ON                                                        \
    -DENABLE_COLORING=ON                                                        \
    -DENABLE_UNIT_TESTS=ON                                                      \
    -DENABLE_DEVEL_TARGETS=OFF                                                  \
    -DFLECSI_RUNTIME_MODEL=hpx                                                  \
    -DCMAKE_BUILD_TYPE=Debug                                                    \
..