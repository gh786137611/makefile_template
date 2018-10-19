OUTPUT_DIR := bin
CXXFLAGS := -O2 -std=c++11
CXX := g++
MAKE := @make 
MKDIR := @mkdir
export CXX CXXFLAGS MAKE MKDIR


cur_dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
obj_dir := $(cur_dir)/$(OUTPUT_DIR)
target := $(obj_dir)/a.out
objs :=  $(wildcard *.cpp)
objs := $(patsubst %.cpp, %.o, $(objs)) 
objs := $(addprefix $(obj_dir)/, $(objs))
deps := $(patsubst %.o, %.d, $(objs))


sub_objs1 := print1.o subdir1.o
sub_objs2 := print2.o subdir2.o
subobj_dir1 := $(obj_dir)/subdir1
subobj_dir2 := $(obj_dir)/subdir2
sub_objs1 := $(addprefix $(subobj_dir1)/, $(sub_objs1))
sub_objs2 := $(addprefix $(subobj_dir2)/, $(sub_objs2))

all: $(target)

-include $(deps)

$(target): $(objs) $(sub_objs1) $(sub_objs2)
	$(CXX) $(CXXFLAGS) $^ -o $@

obj_dir_ := $(subst /,\/,$(obj_dir))
obj_dir_ := $(strip $(obj_dir_))
$(objs): $(obj_dir)/%.o : %.cpp
	$(MKDIR) -p $(obj_dir)
	$(CXX) $(CXXFLAGS) -MM $< | sed "s/.\{1,\}\.o:/$(obj_dir_)\/&/g" > $(patsubst %.o, %.d, $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(sub_objs1):
	$(MKDIR) -p $(subobj_dir1)
	$(MAKE) $@ -C subdir1 OUTPUT_DIR=$(subobj_dir1)

$(sub_objs2):
	$(MKDIR) -p $(subobj_dir2)
	$(MAKE) $@ -C subdir2 OUTPUT_DIR=$(subobj_dir2)
	
	
.PHONY: $(sub_objs1) $(sub_objs2) clean

clean:
	rm -rf $(OUTPUT_DIR)

