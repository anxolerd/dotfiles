========
dotFiles
========

This repository contains configuration files for my laptop. This one is heavily
inspired by and a lot of solutions were borrowed from
`webknjaz/ansible-gentoo-laptop
<https://github.com/webknjaz/ansible-gentoo-laptop>`_


How To Run
----------

.. code-block:: bash

   $ python -m venv .venv
   $ . ./.venv/bin/activate
   $ pip install ansible

   $ # Install apps:
   $ ansible-playbook -DvK install-apps.yml

   $ # Configure userspace:
   $ ansible-playbook -Dv configure-userspace.yml

   $ # Update all packages
   $ ansible-playbook -DvK rebuild-world.yml

   $ # rebuild kernel
   # genkernel --luks --lvm --no-zfs --menuconfig --kernel-config=/proc/config.gz all --bootloader=grub2


Credits
-------

- Original idea and inspiration from `webknjaz/ansible-gentoo-laptop
  <https://github.com/webknjaz/ansible-gentoo-laptop>`_
- Lightdm greeter background is `Honda Africa Twin CRF 1100 2020 by André
  Oliveira
  <https://500px.com/photo/1015687526/Honda-Africa-Twin-CRF-1100-2020-by-Andr%C3%A9-Oliveira/>`_
