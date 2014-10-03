#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import pywikibot
import sirius_si
import sirius_bo
import sirius_li
import sirius_tb
import sirius_ts


sort_flag = False
list_flag = False
bot_default_comment = ('Automatically generated by ' + os.path.basename(__file__))

def check_deps(parameters):
    names = [parameter.name for parameter in parameters]
    for parameter in parameters:
        msg = ''
        deps = parameter.deps
        for dep in deps:
            if dep not in names:
                if msg is '':
                    msg = str(parameter.name) + ': ' + str(dep)
                else:
                    msg += ', ' + str(dep)

        if msg is not '':
            print(msg)

def generate_parameter_name_list_page(label, parameters):
    if list_flag:
        #print('parameter name list page for ' + label + ' will be sent')
        pass
    else:
        wiki = []
        for parameter in parameters:
            name = parameter.name.replace(label+' ', '')
            name_capitalized = name[0].upper() + name[1:]
            line = '#[[Parameter:' + parameter.name + '|' + name_capitalized + ']]'
            wiki.append(line)
        
        site = pywikibot.Site('en', 'siriuswiki')
        page = pywikibot.Page(site, 'Machine:' + label + ' parameter name list')
        page.text = '\n'.join(wiki)
        page.save(bot_default_comment)
    
def generate_parameter_flat_list_page(label, parameters):
    if list_flag:
        #print('parameter flat list page for ' + label + ' will be sent')
        pass
    else:
        wiki = []
        for parameter in parameters:
            name = parameter.name.replace(label+' ', '')
            name_capitalized = name[0].upper() + name[1:]
            wiki.append('=[[Parameter:'+parameter.name+'|'+name_capitalized+']]=')
            wiki.append("'''Data'''")
            wiki.append('{{#lst:Parameter:'+parameter.name+'|data}}')
            wiki.append("'''Observations'''")
            wiki.append('')
            wiki.append('{{#lst:Parameter:'+parameter.name+'|obs}}')
        site = pywikibot.Site('en', 'siriuswiki')
        page = pywikibot.Page(site, 'Machine:' + label + ' parameter flat list')
        page.text = '\n'.join(wiki)
        page.save(bot_default_comment)
            
def generate_parameter_pages(parameters):
    if list_flag:
        for parameter in parameters:
            print(parameter.name)
    else:
        site = pywikibot.Site('en', 'siriuswiki')  
        for parameter in parameters: 
            page = pywikibot.Page(site, 'Parameter:'+parameter.name)
            page.text = parameter.create_wiki_page()
            page.save(bot_default_comment)
            
def update_submachine(submachine, parameters_name_list = None):
    if sort_flag:
        submachine.parameter_list.sort()
    if parameters_name_list is None:
        generate_parameter_pages(submachine.parameter_list)
        generate_parameter_name_list_page(submachine.label, submachine.parameter_list)
        generate_parameter_flat_list_page(submachine.label, submachine.parameter_list)
        return
    if len(parameters_name_list) == 0:
        return
    #print('<'+submachine.label+'>')
    parm_names = [p.name for p in submachine.parameter_list]
    parameter_updated = False
    parameters_name_list.sort()
    for parameter_name in parameters_name_list:
        try:
            idx = parm_names.index(parameter_name)
            parm = submachine.parameter_list[idx]
            generate_parameter_pages([parm])
            #print(parm.name + ' updated.')
            parameter_updated = True
        except ValueError:
            print(parameter_name + ' not defined!')
    if parameter_updated:
        generate_parameter_name_list_page(submachine.label, submachine.parameter_list)
        generate_parameter_flat_list_page(submachine.label, submachine.parameter_list)
        #print('"Machine:'+submachine.label+' parameter name list" page updated.')
    
def update_all():
    
    update_submachine(submachine = sirius_si)
    update_submachine(submachine = sirius_bo)
    update_submachine(submachine = sirius_li)
    update_submachine(submachine = sirius_ts)
    update_submachine(submachine = sirius_tb)
      
def lists_all_parameters():
    
    def list_submachine(submachine):
        if sort_flag:
            submachine.parameter_list.sort()
        print('<'+submachine.label+'>')
        for i in range(len(submachine.parameter_list)):
            print('{0:03d}. {1}'.format(i+1, submachine.parameter_list[i].name))
    
    list_submachine(sirius_si)
    list_submachine(sirius_bo)
    list_submachine(sirius_li)
    list_submachine(sirius_ts)
    list_submachine(sirius_tb)
    
def print_help(argv):
    print('NAME')
    print('      ' + 'updatewiki' + ' - updates Sirius wiki pages' )
    print('')
    print('SYNOPSIS')
    print('      ' + 'updatewiki' + ' [STRING1] [STRING2] [STRING3]...')
    print('')
    print('EXAMPLES')
    print('      ' + '01. updates all parameters in Sirius wiki:')
    print('      ' + 'updatewiki')
    print('')
    print('      ' + '02. updates all parameters but sorting first:')
    print('      ' + 'updatewiki' + ' --sort')
    print('')
    print('      ' + '03. updates all storage ring parameters:')
    print('      ' + 'updatewiki' + ' --si')
    print('')
    print('      ' + '04. updates all booster parameters:')
    print('      ' + 'updatewiki' + ' --bo')
    print('')
    print('      ' + '05. updates all linac parameters:')
    print('      ' + 'updatewiki' + ' --li')
    print('')
    print('      ' + '06. updates all linac to booster transport line parameters:')
    print('      ' + 'updatewiki' + ' --tb')
    print('')
    print('      ' + '07. updates all booster to storage ring transport line parameters:')
    print('      ' + 'updatewiki' + ' --ts')
    print('')
    print('      ' + '08. updates all storage ring parameters whose names have "beam size" substring:')
    print('      ' + 'updatewiki' + ' --si "beam size"')
    print('')
    print('      ' + '09. lists what will be updated.')
    print('      ' + 'updatewiki' + ' --si "beam size" --just-print')
    print('')
    

def find_parms_matching_pattern(submachine, arg):
    
    parms = []
    for parameter in submachine.parameter_list:
        if (arg == 'all') or (arg in parameter.name):
            parms.append(parameter.name)
            #print(parameter)
    return parms
    
def process_arguments(argv):
    
    global sort_flag
    global list_flag
    
    if len(argv) < 2:
        update_all()
    else:
        selected_submachine  = None
        submachines = {
                       'si': [sirius_si, []], 
                       'bo': [sirius_bo, []],
                       'li': [sirius_li, []],
                       'ts': [sirius_ts, []],
                       'tb': [sirius_tb, []]
                       }
    
        #parms_lists = {'si':[], 'bo':[], 'li':[], 'ts':[], 'tb':[]}
        #subma_flags = {'si':False, 'bo':False, 'li':False, 'ts':False, 'tb':False}
        #all_parms   = {'si':sirius_si, 'bo':sirius_bo, 'li':sirius_li, 'ts': sirius_tb, 'tb': sirius_ts}
        
        '''builds lists with parameters'''
        for arg in argv[1:]:
            
            if arg == '--help':
                print_help(argv)
            elif arg == '--list-all':
                lists_all_parameters()
            elif arg == '--sort':
                sort_flag = True    
            elif arg == '--just-print':
                list_flag = True
            elif arg == '--si':
                selected_submachine = submachines['si']
            elif arg == '--bo':
                selected_submachine = submachines['bo']
            elif arg == '--li':
                selected_submachine = submachines['li']
            elif arg == '--ts':
                selected_submachine = submachines['ts']
            elif arg == '--tb':
                selected_submachine = submachines['tb']
            else:
                if selected_submachine is None:
                    print_help(argv)
                else:
                    selected_submachine[1] = selected_submachine[1] + find_parms_matching_pattern(selected_submachine[0], arg)
                
        ''' calls updating functions '''    
        for (submachine, submachine_parms_list) in submachines.values():
            if submachine_parms_list:
                update_submachine(submachine, submachine_parms_list)
                
                    
                    
                
if __name__ == "__main__":
    
    argv = sys.argv
    #print(argv)
    #argv = ['updatewiki.py', '--just-print', '--si', 'beam']
    process_arguments(argv)
