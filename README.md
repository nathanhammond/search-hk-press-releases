# Search Hong Kong Government Press Releases

Search Hong Kong government press release titles by regular expression and archive the matching press releases.

## Usage

`./search.sh START_DATE OUTPUT_FOLDER "REGULAR_EXPRESSION"`

- START_DATE: YYYY-MM-DD date format. Sets the oldest date to include for press releases.
- OUTPUT_FOLDER: The directory for the output archive.
- REGULAR_EXPRESSION: Must be quoted. This search string is passed into `grep`.

Running the command multiple times is idempotent—it will not change any existing files.

## Examples

- `./search.sh 2019-12-31 ha "public hospital.*(wuhan|covid)"`
- `./search.sh 2019-12-31 chp "CHP.*(pneumonia|coronavirus|COVID-19)"`
