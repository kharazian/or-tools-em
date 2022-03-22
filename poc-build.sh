#!/bin/bash

# Make sure we have a 'wasmbuild' folder.
if [ ! -d "wasmpoc" ]; then
    mkdir wasmpoc
fi

# Remove the 'out' folder if it exists.
if [ -d "out" ]; then
    rm -rf out
fi

# In order to find the Emscripten build tools, we need to configure some environment variables so they are available during the build. The required environment variables are initialized by sourcing the 'emsdk_env.sh' that ships with the Emscripten SDK.
pushd emscripten
    echo "Configuring Emscripten environment variables"
    . ./emsdk_env.sh
popd

emcc -O3 \
    --bind \
    -s ERROR_ON_UNDEFINED_SYMBOLS=0 \
	-s ALLOW_MEMORY_GROWTH=1 \
	-s ASSERTIONS=1 \
    -I wasmbuild/install/include \
    -Lwasmbuild/install/lib \
    -labsl_bad_any_cast_impl \
    -labsl_bad_optional_access \
    -labsl_bad_variant_access \
    -labsl_base \
    -labsl_city \
    -labsl_civil_time \
    -labsl_cord \
    -labsl_cord_internal \
    -labsl_cordz_functions \
    -labsl_cordz_handle \
    -labsl_cordz_info \
    -labsl_cordz_sample_token \
    -labsl_debugging_internal \
    -labsl_demangle_internal \
    -labsl_examine_stack \
    -labsl_exponential_biased \
    -labsl_failure_signal_handler \
    -labsl_flags \
    -labsl_flags_commandlineflag \
    -labsl_flags_commandlineflag_internal \
    -labsl_flags_config \
    -labsl_flags_internal \
    -labsl_flags_marshalling \
    -labsl_flags_parse \
    -labsl_flags_private_handle_accessor \
    -labsl_flags_program_name \
    -labsl_flags_reflection \
    -labsl_flags_usage \
    -labsl_flags_usage_internal \
    -labsl_graphcycles_internal \
    -labsl_hash \
    -labsl_hashtablez_sampler \
    -labsl_int128 \
    -labsl_leak_check \
    -labsl_leak_check_disable \
    -labsl_log_severity \
    -labsl_low_level_hash \
    -labsl_malloc_internal \
    -labsl_periodic_sampler \
    -labsl_random_distributions \
    -labsl_random_internal_distribution_test_util \
    -labsl_random_internal_platform \
    -labsl_random_internal_pool_urbg \
    -labsl_random_internal_randen \
    -labsl_random_internal_randen_hwaes \
    -labsl_random_internal_randen_hwaes_impl \
    -labsl_random_internal_randen_slow \
    -labsl_random_internal_seed_material \
    -labsl_random_seed_gen_exception \
    -labsl_random_seed_sequences \
    -labsl_raw_hash_set \
    -labsl_raw_logging_internal \
    -labsl_scoped_set_env \
    -labsl_spinlock_wait \
    -labsl_stacktrace \
    -labsl_status \
    -labsl_statusor \
    -labsl_strerror \
    -labsl_str_format_internal \
    -labsl_strings \
    -labsl_strings_internal \
    -labsl_symbolize \
    -labsl_synchronization \
    -labsl_throw_delegate \
    -labsl_time \
    -labsl_time_zone \
    -lCbc -lCbcSolver -lCgl -lClp -lClpSolver -lCoinUtils -lortools -lOsi -lOsiCbc -lOsiClp -lprotobuf -lscip -lz \
    examples/cpp/min_cost_flow2.cc \
    -o wasmpoc/min_cost_flow2.js 