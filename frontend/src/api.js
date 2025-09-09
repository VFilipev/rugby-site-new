export const PlayersUrl= '/api/players/'
export const MatchesUrl= '/api/matches/'
export const TournamentsUrl= '/api/tournaments/'
export const EventsUrl= '/api/events/'
export const SponsorsUrl= '/api/sponsors/'
export const SeasonsUrl= '/api/seasons/'
export const TeamsUrl= '/api/teams/'
export const StaffTypesUrl= '/api/staff-types/'
export const SchoolsUrl= '/api/schools/'
import axios from 'axios'

function toURLParams(filters){
    let params = new URLSearchParams();
    for (let f in filters){
        if (Array.isArray(filters[f])){
            for (let p of filters[f]){
                if (p){
                    if(p.id){
                        params.append(f,p.id);
                    }else{
                        params.append(f,p);
                    }
                }
            }
        }else if (filters[f] && filters[f].id){
            params.append(f,filters[f]['id'])

        }else{
                if (filters[f] !=undefined){
            params.append(f,filters[f]);
                }

        }
    }
    return params
}

async function _save(url,obj){
    let response
    if (obj.id){
         response = await axios.patch(url+obj.id+'/',obj)
    }else{
         response = await axios.post(url,obj)
    }
    return response.data
}

async function _delete(url,obj){
    let response
    if (obj.id){
        response = await axios.delete(url+obj.id+'/',obj)
    }

    return response
}
async function _getList(url,filter,params={}){
    const response = await axios.get(url+'?'+toURLParams(filter),params)
    return response.data
}
async function _getById(url,id){
    const response = await axios.get(url+id+'/')
    return response.data
}


function apiConstructor(apiUrl){
    return {
        async save(obj){
            return _save(apiUrl,obj)
        },
        async getById(obj){
            return _getById(apiUrl,obj)
        },
        async getList(filter,params={}){
            return _getList(apiUrl,filter,params)
        },
        async delete(obj){
            return _delete(apiUrl,obj)
        }

    }
}

export let Players = apiConstructor(PlayersUrl)
export let Matches = apiConstructor(MatchesUrl)
export let Tournaments = apiConstructor(TournamentsUrl)
export let Events = apiConstructor(EventsUrl)
Events.mainPage = async()=>{
    const response = (await axios.get(EventsUrl+'main_page/')).data
    return response
}
Events.recent = async()=>{
    const response = (await axios.get(EventsUrl+'recent/')).data
    return response
}
export let Sponsors = apiConstructor(SponsorsUrl)
export let Seasons = apiConstructor(SeasonsUrl)
export let Teams = apiConstructor(TeamsUrl)
export let StaffTypes = apiConstructor(StaffTypesUrl)
export let Schools = apiConstructor(SchoolsUrl)

