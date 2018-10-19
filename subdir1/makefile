objs := $(wildcard *.cpp)
objs := $(patsubst %.cpp, %.o, $(objs))
objs := $(addprefix $(OUTPUT_DIR)/, $(objs))
obj_dir := $(OUTPUT_DIR)
deps := $(patsubst %.o, %.d, $(objs))
-include $(deps)
obj_dir_ := $(subst /,\/, $(obj_dir))
obj_dir_ := $(strip $(obj_dir_))

$(objs): $(obj_dir)/%.o : %.cpp
	$(CXX) $(CXXFLAGS) -MM $< | sed "s/.\{1,\}\.o:/$(obj_dir_)\/&/g" > $(patsubst %.o, %.d, $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

