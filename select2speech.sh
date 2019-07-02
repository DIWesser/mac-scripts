#!/bin/bash
#
# Takes selected text and reads it.
# Todo:
# - Have it find running versions of itself and kill them before it starts. I'm
#   not a big fan of having multiple robots yelling at me.

xsel | festival --tts
