
work_dir=$(cd "$(dirname "$0")";pwd)

echo "start gencode=$gencode"
if [ -z ${gencode} ];
then
    gencode=35
fi
echo "gencode=$gencode"
out_dir=${work_dir}/bin
mkdir -p ${out_dir}
exe_name=${out_dir}/test
inc_dirs="-I/usr/local/musa/include -I${work_dir} "
src_dirs=( ${work_dir})
lib_dirs=( -L/usr/local/musa/lib64 )
obj_dir="${work_dir}/obj"
if [ ${obj_dir} ]; then
    rm -rf ${obj_dir} 
    mkdir ${obj_dir} 
fi

if [ ! -d "${out_dir}" ]; then
    mkdir -p "${out_dir}"
fi
libs=( -lmusadevrt -lmublas -lmudart -lmusa -lc -lm -lpthread )
files=()
set -e
for dir in "${src_dirs[@]}"
do
    tmp_files=`ls ${dir}/*.mu `
    files=(${files[@]} ${tmp_files[@]})
	echo "${dir}:${tmp_files}"
done

obj_files=""
for file in "${files[@]}"
do
    tmp_file=${file##*/}
    obj_file=${tmp_file/%.mu/.o}
    obj_file=${obj_dir}/${obj_file}
	echo "obj_file = ${obj_file}"
    mcc -v -G --disable-warnings -g -w -O3 -o ${obj_file} -m64 -std=c++11 -fPIC ${inc_dirs} ${lib_dirs} ${libs} -c ${file}
    obj_files="${obj_files} ${obj_file} "
done
echo "nvcc for end!!"

mcc   -G   --disable-warnings -g  -w   -o ${exe_name} -m64   -std=c++11  ${inc_dirs}  ${obj_files} ${lib_dirs} ${libs} 

echo "gencode=70,80"

