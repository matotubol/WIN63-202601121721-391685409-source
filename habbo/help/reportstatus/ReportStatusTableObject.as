package com.sulake.habbo.help.reportstatus
{
   import com.sulake.habbo.help.MyReportStatus;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   import flash.globalization.DateTimeFormatter;
   import package_40.class_2748;
   
   public class ReportStatusTableObject implements ITableObject
   {
      
      private var _myReportStatus:MyReportStatus;
      
      private var var_986:class_2748;
      
      private var var_2437:DateTimeFormatter;
      
      private var var_2989:Object;
      
      public function ReportStatusTableObject(param1:MyReportStatus, param2:class_2748)
      {
         super();
         _myReportStatus = param1;
         var_986 = param2;
         var_2437 = new DateTimeFormatter("i-default");
         var_2437.setDateTimePattern("dd/MM/yyyy");
         var_2989 = getReportedUserDeleted(var_986.reportedAccountName);
      }
      
      public function get identifier() : String
      {
         return String(var_986.id);
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         return true;
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         return true;
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case MyReportStatus.COLUMN_REPORT_DATE:
               _loc2_ = var_2437.format(new Date(var_986.creationTime));
               return new TableCell(TableCell.var_101,_loc2_);
            case MyReportStatus.COLUMN_REPORTED_ACCOUNT:
               return new TableCell(TableCell.var_101,var_2989.userName,false,false,null,null,false,null,var_2989.textColor);
            case MyReportStatus.COLUMN_REASON:
               return new TableCell(TableCell.var_101,_myReportStatus.localize("help.cfh.topic." + var_986.userCategory));
            case MyReportStatus.COLUMN_APPEAL_STATUS:
               var _loc3_:TableCell = new TableCell(TableCell.var_101,statusText);
               if(!var_2989.deleted)
               {
                  null.setExtraBtn("icons_info_grey",onExtraClick);
               }
               return null;
            default:
               return null;
         }
      }
      
      private function onExtraClick() : void
      {
         _myReportStatus.clickInfoButton(this);
      }
      
      private function get statusText() : String
      {
         var _loc1_:String = null;
         switch(var_986.appealStatus)
         {
            case class_2748.var_4277:
               _loc1_ = "report.status.state.decided";
               break;
            case class_2748.name_7:
               _loc1_ = "report.status.state.pending";
               break;
            default:
               _loc1_ = "report.status.state.appealed";
         }
         return _myReportStatus.localize(_loc1_);
      }
      
      private function getReportedUserDeleted(param1:String) : Object
      {
         var _loc2_:Boolean = param1 == null || param1 == "";
         var _loc4_:String = _loc2_ ? _myReportStatus.localize("report.status.deleted","Deleted") : param1;
         var _loc3_:int = _loc2_ ? 13762560 : 0;
         return {
            "deleted":_loc2_,
            "userName":_loc4_,
            "textColor":_loc3_
         };
      }
      
      public function get message() : class_2748
      {
         return var_986;
      }
   }
}

