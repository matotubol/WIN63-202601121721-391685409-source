package com.sulake.habbo.roomevents.wired_menu.variables_management.overview
{
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_inspection.VariableValueTableObject;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   import package_117.WiredGetUserPermanentVariablesComposer;
   import package_189.WiredVariable;
   import package_201.WiredUserVariablesElement;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   
   public class VariableManagementOverviewTableObject implements ITableObject
   {
      
      private var var_55:VariableManagementOverviewController;
      
      private var var_347:WiredUserVariablesElement;
      
      private var var_1108:WiredVariable;
      
      public function VariableManagementOverviewTableObject(param1:VariableManagementOverviewController, param2:WiredUserVariablesElement, param3:WiredVariable)
      {
         super();
         var_55 = param1;
         var_347 = param2;
         var_1108 = param3;
      }
      
      public function get identifier() : String
      {
         return var_347.entityType + "-" + var_347.entityId;
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         switch(param1)
         {
            case "usertype":
               return new TableCell(TableCell.var_101,localize("wiredfurni.params.usertype." + var_347.entityType));
            case "name":
               if(var_347.entityType == 1)
               {
                  return new TableCell(TableCell.var_2973,var_347.entityName,false,true,null,onClickUsername);
               }
               return new TableCell(TableCell.var_101,var_347.entityName,false,true);
               break;
            case "creation_time":
               return new TableCell(TableCell.var_101,var_347.storage.creationTimeStr,false,true);
            case "last_update_time":
               return new TableCell(TableCell.var_101,var_347.storage.lastUpdateTimeStr,false,true);
            case "value":
               return VariableValueTableObject.createVariableValueCell(var_1108,var_347.storage.value,var_55.roomEvents,false,false);
            case "manage":
               return new TableCell(TableCell.var_2973,localize("wiredmenu.variable_management.manage"),false,false,null,onClickManage);
            default:
               return null;
         }
      }
      
      private function onClickUsername() : void
      {
         var_55.send(new GetExtendedProfileMessageComposer(var_347.entityId,true));
      }
      
      private function onClickManage() : void
      {
         var_55.send(new WiredGetUserPermanentVariablesComposer(var_347.entityType,var_347.entityId));
      }
      
      private function localize(param1:String) : String
      {
         return localization.getLocalization(param1);
      }
      
      private function get localization() : class_27
      {
         return var_55.localizationManager;
      }
      
      public function get element() : WiredUserVariablesElement
      {
         return var_347;
      }
      
      public function get variable() : WiredVariable
      {
         return var_1108;
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         var _loc3_:VariableManagementOverviewTableObject = param2 as VariableManagementOverviewTableObject;
         if(param1 == "creation_time")
         {
            return var_347.storage.creationTime != _loc3_.element.storage.creationTime;
         }
         if(param1 == "last_update_time")
         {
            return var_347.storage.lastUpdateTime != _loc3_.element.storage.lastUpdateTime;
         }
         if(param1 == "value")
         {
            return var_347.storage.value != _loc3_.element.storage.value || var_1108.hasValue != _loc3_.variable.hasValue;
         }
         return false;
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         return isPropertyUpdated("creation_time",param1) || isPropertyUpdated("last_update_time",param1) || isPropertyUpdated("value",param1);
      }
   }
}

