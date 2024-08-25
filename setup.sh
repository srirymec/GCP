#!/bin/bash

# Define email parameters
TO="srinivasa.bester@accenture.com"
SUBJECT="Terraform Plan Review Required"
BODY="The Terraform plan is ready for review. You can download it here: https://storage.googleapis.com/$BUCKET_NAME/$TFPLAN_FILE"

# Send email using sendmail
echo -e "To: $TO\nSubject: $SUBJECT\n\n$BODY" | sendmail -t