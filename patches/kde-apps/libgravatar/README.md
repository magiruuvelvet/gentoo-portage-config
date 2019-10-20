Gravatar is DNS blocked in my network, but remove this bullshit anyway so Akonadi
never attempts make network requests to Gravatar. Also gets rid of the cache
and returns an invalid QPixmap for everything, which results in an empty QLabel
in the user interface.
