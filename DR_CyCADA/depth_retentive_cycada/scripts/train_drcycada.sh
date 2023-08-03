seed=0
#----------------- Options ---------------
#----------------# Experiments -------------
# M->U
MODEL_NUM=1_${seed}
dataroot="/home/rail/DR_CyCADA/depth_retentive_cycada/data/habitat_dataset_dr_cycada"
dataset_mode="class_unaligned"
c_A_name="lenet_mnist_acc_97.5000.pt" # acc 91 in U
netC="lenet"
lambda_A=1
lambda_B=1
load_size=32
crop_size=32
c_lr=0.001
gpu_ids="0"
batch_size=4
direction="AtoB"
#direction="BtoA"
num_threads=4

# U->M
MODEL_NUM=2_${seed}
dataroot="/media/rail/DATA/DR_CyCADA/depth_retentive_cycada/data/habitat_dataset_dr_cycada"
dataset_mode="class_unaligned"
c_A_name="lenet_usps_acc_97.1599.pt" # acc 68 in m
netC="lenet"
model_type=""
lambda_A=1
lambda_B=1
lambda_dpt_A=1
lambda_dpt_B=1
load_size=32
crop_size=32
c_lr=0.001
gpu_ids="0"
batch_size=4
#direction="AtoB"
direction="BtoA"
num_threads=4
#----------------- Basics ----------------
niter=200
niter_decay=100
continue_train=0
epoch="latest"
epoch_count=1

pretrain=1
pretrain_epoch=0
print_freq=$((${batch_size}*100)) #around 500
eval_step_freq=$((${batch_size}*100)) # for eval, around 1000
preprocess="resize"
input_nc=3
output_nc=3
#----------------- Basics ----------------
model="drcycada" #change to cycada for regular cycada
DATE=`date "+%Y%m%d-%H%M%S"`
echo ${DATE}
name=${model}_${MODEL_NUM}
save_by_iter=0
max_gnorm=500
monitor_gnorm=0
beta1=0.5
checkpoints_dir="./checkpoints"
gan_mode="lsgan"
init_gain=0.02
init_type="normal"
load_iter=0
lr=0.0007
lr_decay_iters=50
lr_policy="linear"
max_dataset_size=100000000 #inf
phase="train"
save_epoch_freq=1 # for save
save_latest_freq=$((${batch_size}*1000))
serial_batches=0
no_flip=1
suffix=""
verbose=0
#----------------- Network----------------
n_layers_D=4
ngf=64
ndf=64
netD="n_layers"
netG="resnet_2blocks"
no_dropout=1
norm="instance"
#----------------- End -------------------

#labda dpt must be removed for regular cycada
python3 train.py \
--monitor_gnorm=${monitor_gnorm} \
--batch_size=${batch_size} \
--beta1=${beta1} \
--checkpoints_dir=${checkpoints_dir} \
--continue_train=${continue_train} \
--crop_size=${crop_size} \
--c_lr=${c_lr} \
--c_A_name=${c_A_name} \
--dataroot=${dataroot} \
--dataset_mode=${dataset_mode} \
--direction=${direction} \
--seed=${seed} \
--epoch=${epoch} \
--epoch_count=${epoch_count} \
--gan_mode=${gan_mode} \
--gpu_ids=${gpu_ids} \
--init_gain=${init_gain} \
--init_type=${init_type} \
--input_nc=${input_nc} \
--lambda_A=${lambda_A} \
--lambda_B=${lambda_B} \
--lambda_dpt_A=${lambda_dpt_A} \
--lambda_dpt_B=${lambda_dpt_B} \
--load_iter=${load_iter} \
--load_size=${load_size} \
--lr=${lr} \
--lr_decay_iters=${lr_decay_iters} \
--lr_policy=${lr_policy} \
--max_dataset_size=${max_dataset_size} \
--model=${model} \
--n_layers_D=${n_layers_D} \
--name=${name} \
--ndf=${ndf} \
--netD=${netD} \
--netG=${netG} \
--netC=${netC} \
--ngf=${ngf} \
--niter=${niter} \
--niter_decay=${niter_decay} \
--no_dropout=${no_dropout} \
--no_flip=${no_flip} \
--norm=${norm} \
--num_threads=${num_threads} \
--output_nc=${output_nc} \
--phase=${phase} \
--print_freq=${print_freq} \
--preprocess=${preprocess} \
--pretrain=${pretrain} \
--pretrain_epoch=${pretrain_epoch} \
--save_by_iter=${save_by_iter} \
--save_epoch_freq=${save_epoch_freq} \
--eval_step_freq=${eval_step_freq} \
--save_latest_freq=${save_latest_freq} \
--serial_batches=${serial_batches} \
--suffix=${suffix} \
--verbose=${verbose} \
--max_gnorm=${max_gnorm} \
