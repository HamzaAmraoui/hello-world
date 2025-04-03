#!/bin/bash
env=$1

hackaton deploy --$env
hackaton restart app --$env
