package com.sulake.habbo.roomevents.wired_menu.roomlogs
{
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   import package_203.WiredLogEntry;
   
   public class WiredRoomLogListTableObject implements ITableObject
   {
      
      private static var COLOR_INFO:uint = 4607;
      
      private static var COLOR_WARN:uint = 11757568;
      
      private static var COLOR_ERROR:uint = 14362624;
      
      private static var COLOR_DEBUG:uint = 10158534;
      
      private static var COLORS:Array = [COLOR_INFO,COLOR_WARN,COLOR_ERROR,COLOR_DEBUG];
      
      private var var_55:WiredRoomLogListController;
      
      private var var_347:WiredLogEntry;
      
      public function WiredRoomLogListTableObject(param1:WiredRoomLogListController, param2:WiredLogEntry)
      {
         super();
         var_55 = param1;
         var_347 = param2;
      }
      
      public function get identifier() : String
      {
         return String(var_347.id);
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         var _loc2_:int = int(COLORS[var_347.logLevel]);
         switch(param1)
         {
            case "timestamp":
               return new TableCell(TableCell.var_101,var_347.timestampStr,false,true,null,null,false,null,_loc2_);
            case "source":
               return new TableCell(TableCell.var_101,localize("wiredmenu.logs_overview.log_source." + var_347.logSource),false,false,null,null,false,null,_loc2_);
            case "level":
               return new TableCell(TableCell.var_101,localize("wiredmenu.logs_overview.log_level." + var_347.logLevel),false,false,null,null,false,null,_loc2_);
            case "message":
               return new TableCell(TableCell.var_101,var_347.logMessage,false,true,null,null,false,null,_loc2_);
            default:
               return null;
         }
      }
      
      private function localize(param1:String) : String
      {
         return localization.getLocalization(param1);
      }
      
      private function get localization() : class_27
      {
         return var_55.localizationManager;
      }
      
      public function get element() : WiredLogEntry
      {
         return var_347;
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         return false;
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         return false;
      }
   }
}

