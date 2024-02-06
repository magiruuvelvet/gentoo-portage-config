# `force-disable-dgpu-support.patch`

This will work on my new laptop, so forcefully remove the entire check to avoid unwanted surprises with desktop files containing a `X-KDE-RunOnDiscreteGpu` key. Preserve the current behavior with a modified `primerun` script.
