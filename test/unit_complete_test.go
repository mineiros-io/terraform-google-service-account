package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestUnitComplete(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "unit-complete",
		Vars: map[string]interface{}{
			"gcp_project": os.Getenv("TF_VAR_GCP_PROJECT"),
		},
		Upgrade: true,
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndPlan(t, terraformOptions)
	terraform.ApplyAndIdempotent(t, terraformOptions)

	// Replace ApplyAndIdempotent() check with below code if provider and terraform report output changes that
	// can not be prevented due to some bugs in this feature

	// terraform.Apply(t, terraformOptions)

	// stdout := terraform.Plan(t, terraformOptions)

	// resourceCount := terraform.GetResourceCount(t, stdout)
	// assert.Equal(t, 0, resourceCount.Add, "No resources should have been created. Found %d instead.", resourceCount.Add)
	// assert.Equal(t, 0, resourceCount.Change, "No resources should have been changed. Found %d instead.", resourceCount.Change)
	// assert.Equal(t, 0, resourceCount.Destroy, "No resources should have been destroyed. Found %d instead.", resourceCount.Destroy)
}
