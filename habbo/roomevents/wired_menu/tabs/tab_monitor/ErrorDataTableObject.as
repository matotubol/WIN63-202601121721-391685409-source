package com.sulake.habbo.roomevents.wired_menu.tabs.tab_monitor
{
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   import package_97.class_4089;
   
   public class ErrorDataTableObject implements ITableObject
   {
      
      private var var_4421:WiredMenuMonitorTab;
      
      private var var_24:class_4089;
      
      private var _localization:class_27;
      
      public function ErrorDataTableObject(param1:WiredMenuMonitorTab, param2:class_4089, param3:class_27)
      {
         super();
         var_4421 = param1;
         var_24 = param2;
         _localization = param3;
      }
      
      private static function convertTimestamp(param1:Number) : String
      {
         var _loc2_:Date = new Date(param1);
         var _loc6_:int = _loc2_.fullYear;
         var _loc5_:int = _loc2_.month + 1;
         var _loc8_:int = _loc2_.date;
         var _loc3_:int = _loc2_.hours;
         var _loc7_:int = _loc2_.minutes;
         var _loc4_:int = _loc2_.seconds;
         return _loc6_ + "-" + addLeadingZero(_loc5_) + "-" + addLeadingZero(_loc8_) + " " + addLeadingZero(_loc3_) + ":" + addLeadingZero(_loc7_) + ":" + addLeadingZero(_loc4_);
      }
      
      private static function addLeadingZero(param1:int) : String
      {
         return param1 < 10 ? "0" + param1.toString() : param1.toString();
      }
      
      public function get data() : class_4089
      {
         return var_24;
      }
      
      public function get identifier() : String
      {
         return String(var_24.errorId);
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         var _loc3_:class_4089 = (param2 as ErrorDataTableObject).data;
         switch(param1)
         {
            case WiredMenuMonitorTab.var_4541:
               return var_24.throwCount != _loc3_.throwCount;
            case WiredMenuMonitorTab.LOG_COLUMN_LATEST:
               return var_24.msSinceLastOccurrence != _loc3_.msSinceLastOccurrence;
            default:
               return false;
         }
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         var _loc2_:class_4089 = (param1 as ErrorDataTableObject).data;
         return var_24.msSinceLastOccurrence != _loc2_.msSinceLastOccurrence || var_24.throwCount != _loc2_.throwCount;
      }
      
      public function onLinkClicked() : void
      {
         var_4421.onErrorLinkClicked(var_24);
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         switch(param1)
         {
            case WiredMenuMonitorTab.LOG_COLUMN_TYPE:
               return new TableCell(TableCell.var_2973,var_24.errorName,false,false,null,onLinkClicked);
            case WiredMenuMonitorTab.var_5247:
               return new TableCell(TableCell.var_101,var_24.category);
            case WiredMenuMonitorTab.var_4541:
               return new TableCell(TableCell.var_101,String(var_24.throwCount));
            case WiredMenuMonitorTab.LOG_COLUMN_LATEST:
               if(var_24.msSinceLastOccurrence < 0)
               {
                  return new TableCell(TableCell.var_101,"/");
               }
               return new TableCell(TableCell.var_101,FriendlyTime.getFriendlyTime(_localization,var_24.msSinceLastOccurrence / 1000,".ago",3),false,false,null,null,false,timestampString);
               break;
            default:
               return null;
         }
      }
      
      private function get timestampString() : String
      {
         var _loc1_:Number = new Date().time - var_24.msSinceLastOccurrence;
         _loc1_ -= _loc1_ % 1000;
         return convertTimestamp(_loc1_);
      }
   }
}

