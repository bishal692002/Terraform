# Terraform & Infrastructure as Code (IaC)

## Infrastructure as Code (IaC)

### Traditional Infrastructure (Before IaC)
- Manual configuration of servers → error-prone, inconsistent.  
- No version control → hard to track/revert changes.  
- Relied on lengthy documentation → quickly outdated.  
- Automation limited to scripts → lacked flexibility.  
- Provisioning was slow → delays in delivery.  

### IaC Advantages
- Automates infrastructure setup & management.  
- Ensures consistency and repeatability.  
- Infrastructure can be stored in version control (like Git).  
- Speeds up provisioning and reduces manual errors.  
- Tools: **Terraform, AWS CloudFormation, Azure Resource Manager, etc.**

---

## Why Terraform?

1. **Multi-Cloud Support**  
   - Works across AWS, Azure, GCP, on-premises.  
   - Same code can be reused on different providers.  

2. **Large Ecosystem**  
   - Thousands of providers & community modules.  
   - Saves effort with reusable configurations.  

3. **Declarative Syntax (HCL)**  
   - Define desired *end state* of infrastructure.  
   - More readable than imperative scripting.  

4. **State Management**  
   - Maintains a state file to track current vs. desired infra.  
   - Updates only what’s needed.  

5. **Plan & Apply Workflow**  
   - `terraform plan`: preview changes.  
   - `terraform apply`: implement them safely.  

6. **Community & Documentation**  
   - Huge community, tutorials, troubleshooting guides.  

7. **Integration with Other Tools**  
   - Works well with Ansible, Docker, Kubernetes, Jenkins.  
   - Fits into DevOps pipelines.  

8. **Human-Friendly Language (HCL)**  
   - Easy for both developers and operations teams to understand.  

---

👉 **Terraform = Multi-cloud, reusable, easy-to-read, state-aware, strong community, and integrates with DevOps pipelines.**
