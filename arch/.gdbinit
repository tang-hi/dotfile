python
import os, sys
sys.path.insert(0, '/usr/share/gcc-15.2.1/python/')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers(None)

scripts_dir = os.path.expanduser('~/scripts/')
if os.path.isdir(scripts_dir):
    sys.path.insert(0, scripts_dir)
    from printers import register_eigen_printers
    register_eigen_printers(None)

end
