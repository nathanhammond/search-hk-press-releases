since=$1
output_dir=$2
search=$3

function generate_index {
  mkdir -p index

  start=$1
  end=`date +%Y-%m-%d`

  while ! [[ $start > $end ]]; do
    url_date=$(date -j -f %Y-%m-%d $start +%Y%m/%d)
    [[ -e "index/$start.htm" ]] || curl --silent "https://www.info.gov.hk/gia/general/$url_date.htm" | grep '<li>' | sed 's/<span>//g' | sed "s/<\/span>//g" | sed 's/class="NEW" //g' | sed 's/<!--.*-->//g' | sed "s/href=\"/href=\"https:\/\/www.info.gov.hk/g" | sed 's/&nbsp;/ /g' | awk '{$1=$1;print}' | cat > "index/$start.htm"
    start=$(date -j -v+1d -f %Y-%m-%d $start +%Y-%m-%d)
  done
}

function search {
  output_dir=$1
  search=$2

  mkdir -p $output_dir/press_releases
  mkdir -p $output_dir/press_releases/attachments

  grep -Eri "$search" ./index | sort > $output_dir/list.txt
  cut -d '"' -f 2 $output_dir/list.txt > $output_dir/urls.txt
  wget --no-clobber --no-verbose --directory-prefix="$output_dir/press_releases" -i $output_dir/urls.txt

  grep -Er "attach_text wrap_txt" $output_dir/press_releases | sort | cut -d '"' -f 2 > $output_dir/attachments.txt
  wget --no-clobber --no-verbose --directory-prefix="$output_dir/press_releases/attachments" -i $output_dir/attachments.txt
}

# Update the local archive.
generate_index $since
search "$output_dir" "$search"