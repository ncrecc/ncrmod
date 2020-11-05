if(target.status.length > 0) for(stat in target.status) if(stat.type == POISON) trace(stat.value);
trace(getstatus(POISON));