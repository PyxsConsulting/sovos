managed implementation in class /pyxs/bp_sovosbranchdata unique;
strict ( 2 );
with draft;
define behavior for /PYXS/SovosBranchData //alias <alias_name>
persistent table /pyxs/sov_branch
draft table /pyxs/sov_d_bran
lock master total etag Branch
authorization master ( global )
//etag master <field_name>
{
  create ( authorization : global );
  update;
  delete;

  draft action Activate optimized;
  draft action Discard;
  draft action Edit;
  draft action Resume;
  draft determine action Prepare{
  }

  field ( readonly:update ) CompanyCode, Branch;
  mapping for /pyxs/sov_branch{
   Branch = branch;
   CompanyCode = company_code;
   SovosBranch = sov_branch;
   SovosCompany = sov_company;
  }
}