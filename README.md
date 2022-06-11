# T-Echo Bootloader

This is a port of the _Open DFU Bootloader_ by Nordic Semiconductor to the Lilygo T-Echo.

With this bootloader flashed to your T-Echo, you can update the firmware using the USB-C connector and `nrfutil`.

## Creating an Update Image

Suppose you have built a new firmware version and want to flash it to a device
where this bootloader is already installed. To do that, you first need to
create an update image. A script is provided to simplify that (example for the
`lora-aprs` firmware):

```sh
scripts/create_package.sh ../lora-aprs/_build/nrf52840_xxaa.hex test.zip
```

## Flashing an Image

To flash an image, you first need to invoke the bootloader as follows:

- Press and hold the lower push button on the T-Echo.
- Momentarily press the upper push button (reset).
- Release all buttons.

The LED should now be fading in green to indicate that the bootloader is active.

Connect the T-Echo to your computer via USB and check `dmesg` for the interface
name (should be something like `/dev/ttyACM0`). Then run the flash script:

```sh
scripts/flash_package.sh /dev/ttyACM0 test.zip
```

## Security

This bootloader does not provide any security for firmware updates. Even though
the packages are signed that signature is not checked by the bootloader. So
basically anyone with physical access to your device can flash any firmware.

For simplicity (to make the scripts above directly usable) a default private
key, which is used to sign the packages, is provided in this repository.

However, when the bootloader itself is update through DFU, the signature _is_
checked. So, if you want to make sure only you can overwrite the bootloader via
USB, you must not use the default key and [generate your own
keypair](https://infocenter.nordicsemi.com/topic/ug_nrfutil/UG/nrfutil/nrfutil_keys_generate_display.html)
instead.

If you really need/want signature checks for regular firmware updates, feel
free to port the [Secure
Bootloader](https://infocenter.nordicsemi.com/topic/sdk_nrf5_v17.1.0/ble_sdk_app_secure_bootloader.html)
for the T-Echo based on this version **and generate your own keypair**.

## License

As the modifications from Nordic’s version of the _Open DFU Bootloader_ are
minimal, this version is licensed under there license. See the file headers for
details.
