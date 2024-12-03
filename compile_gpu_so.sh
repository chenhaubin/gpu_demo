
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
inc_dirs="-I/usr/local/cuda/include -I${work_dir} "
src_dirs=( ${work_dir})
lib_dirs=( -L/usr/local/cuda/lib64 )
obj_dir="${work_dir}/obj"
if [ ${obj_dir} ]; then
    rm -rf ${obj_dir} 
    mkdir ${obj_dir} 
fi

if [ !${out_dir} ]; then
    mkdir ${out_dir} 
fi
libs=(  -lcudadevrt -lcublas -lcudart -lcuda  -lc -lm -lpthread )
files=()
set -e
for dir in "${src_dirs[@]}"
do
    tmp_files=`ls ${dir}/*.cu `
    files=(${files[@]} ${tmp_files[@]})
	echo "${dir}:${tmp_files}"
done

obj_files=""
for file in "${files[@]}"
do
    tmp_file=${file##*/}
    obj_file=${tmp_file/%.cu/.o}
    obj_file=${obj_dir}/${obj_file}
	echo "obj_file = ${obj_file}"
    nvcc  -G   --disable-warnings -ccbin g++ -g  -w  -O3  -o ${obj_file} -m64 -std=c++11  --compiler-options -fPIC ${inc_dirs} ${lib_dirs} ${libs}  -rdc=true -gencode=arch=compute_70,code=\"sm_70,compute_70\" -gencode=arch=compute_80,code=\"sm_80,compute_80\" -c ${file}
    obj_files="${obj_files} ${obj_file} "
done
echo "nvcc for end!!"

nvcc   -G   --disable-warnings  -ccbin g++ -g  -w   -o ${exe_name} -m64   -std=c++11  ${inc_dirs} -rdc=true -gencode=arch=compute_70,code=\"sm_70,compute_70\" -gencode=arch=compute_80,code=\"sm_80,compute_80\"  ${obj_files} ${lib_dirs} ${libs} 

echo "gencode=70,80"

