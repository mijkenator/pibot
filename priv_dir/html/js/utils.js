function mkh_api(param_obj)   
{   
   $.ajax({
        type:       param_obj.type || 'POST',
        url:        param_obj.url || '/api',
        data:       {"request" : JSON.stringify(param_obj.data)},
        success:    function(data){
            console.log('MKH_API OK:', mkh_api.caller);
            if(param_obj.success){param_obj.success()}
        },
        error:      function(data){ 
            console.log('MKH_API error:', mkh_api.caller, data);
            if(param_obj.error){param_obj.error()}
        }
    });
}
