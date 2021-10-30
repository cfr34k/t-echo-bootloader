#!/bin/sh

# Set NRF52 regulator voltage to 3.3V, as required on the T-Lora.
nrfjprog --memwr 0x10001304 --val 0x05
