#!/bin/bash

../configure \
  -prefix /opt/qt \
  -ccache \
  -debug \
  -sanitize thread \
  -nomake examples \
  -nomake tests \
  -submodules qtbase,qtsvg,qttools,qtwayland \
  -skip qtactiveqt \
  -skip qtdeclarative \
  -skip qtlanguageserver \
  -skip qtshadertools \
  -no-feature-assistant \
  -no-feature-designer \
  -no-feature-pixeltool \
  -no-feature-printsupport \
  -no-feature-qdoc \
  -no-feature-qtdiag \
  -no-feature-qtplugininfo \
  -no-feature-sql \
  -no-feature-undocommand \
  -no-feature-undogroup \
  -no-feature-undostack \
  -no-feature-undoview \
  -no-glib \
  -opengl desktop
